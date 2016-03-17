class PackRecordsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:index, :show, :update_total_rewards]
  before_action :set_pack_record, only: [:edit, :update, :show, :destroy]
  
  def index
    @pack_records = @user.pack_records
  end

  def show
    @pack_record = @user.pack_records.find(params[:id])
  end

  def new
    @pack_record  = PackRecord.new
  end

  def create
    @pack_record = PackRecord.new pack_record_params
    @user = User.find(@pack_record.user_id)
    @pack = Pack.find(@pack_record.pack_id)
    if @user.pack_records.present?
      @pack_record.posting_number = @user.pack_records.last.posting_number + 1
    else 
      @pack_record.posting_number = 1
    end
    @pack_record.reward = @pack_record.calculate_reward(@user, @pack_record.score, @pack_record)
    update_stock(@pack)
    respond_to do |format|
      if @pack_record.save
        update_total_rewards
        UserMailer.new_work_email(@user, @pack).deliver_now
        flash[:success] = "Pack Record was created successfully."
        format.js { redirect_turbo employee_view_path}
      else
        format.js { render partial: 'shared/ajax_form_errors', locals: {model: @pack_record}, status: 500 }
      end
    end
  end

  def edit
  end
  
  def update
    @user = User.find(@pack_record.user_id)
    respond_to do |format|
      if @pack_record.update_attributes pack_record_params
        @pack_record.reward = @pack_record.calculate_reward(@user, @pack_record.score, @pack_record)
        @pack_record.score = calculate_score(@pack_record)
        @pack_record.save
        update_total_rewards
        flash[:success] = "Pack Record was updated successfully."
        format.js {redirect_turbo employee_view_path}
      else
        format.js { render partial: 'shared/ajax_form_errors', locals: {model: @pack_records}, status: 500 }
      end
    end
  end

  def destroy
    @pack_record.destroy
    redirect_to employee_view_path
  end

  def work_missing_email
    @overdue_packs = PackRecord.overdue
    @overdue_packs.each do |overdue_pack|
      UserMailer.work_missing(User.find(overdue_pack.user_id), overdue_pack).deliver_now
    end
    redirect_to employee_view_path
  end 
 
  private

  def pack_record_params
    params.require(:pack_record).permit(:pack_id, :user_id, :status, :start_date, :posting_number, :score, :due_date, :comment, :accuracy, :completion, :quality, :presentation, :consistency)
  end
    
  def set_pack_record
    @pack_record = PackRecord.find params[:id] rescue nil
    return not_found! unless @pack_record
  end
    
  def set_user
    @user = User.find params[:user_id] rescue nil
    return not_found! unless @user
  end

  def update_stock(pack)
    pack.number_unassigned = pack.number_unassigned - 1
    pack.number_assigned += 1
    pack.save
  end

  def update_total_rewards
    total_rewards = 0
    @user.pack_records.each do |pr|
      total_rewards += pr.reward  
    end
    @user.rewards = total_rewards
    @user.save
  end

  def calculate_score(pack_record)
    accuracy = pack_record[:accuracy].to_i
    completion = pack_record[:completion].to_i
    quality = pack_record[:quality].to_i
    presentation = pack_record[:presentation].to_i
    consistency = pack_record[:consistency].to_i
    score = (0.4 *accuracy + 0.25* completion + 0.15* quality + 0.10*presentation + 0.10*consistency)
  end

end