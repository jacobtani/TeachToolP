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
    compute_pack_record_logic(@user, @pack_record)
    @pack_record.posting_number = PackRecord.compute_posting_number(@user)
    respond_to do |format|
      if @pack_record.save
        User.update_total_rewards(@user)
        Pack.update_stock(Pack.find(@pack))
        UserMailer.new_work_email(@user, @pack).deliver_now
        flash[:success] = "Pack Record was created successfully."
        format.html { redirect_to employee_view_path}
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
        @pack_record = compute_pack_record_logic(@user, @pack_record)
        User.update_total_rewards(@user)
        flash[:success] = "Pack Record was updated successfully."
        format.html { redirect_to employee_view_path }
      else
        format.js { render partial: 'shared/ajax_form_errors', locals: {model: @pack_record}, status: 500 }
      end
    end
  end

  def destroy
    @pack_record.destroy
    redirect_to employee_view_path
  end

  def work_missing_email
    PackRecord.overdue.each do |overdue_pack|
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

  def compute_pack_record_logic(user, pack_record)
    pack_record.score = PackRecord.calculate_score(pack_record)
    pack_record.reward = PackRecord.calculate_reward(pack_record.score)
    #if it is an update action call save
    if (request.env['PATH_INFO'] =~ /\d/) != nil
      pack_record.save
    end 
    pack_record
  end

end