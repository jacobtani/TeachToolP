class PackRecordsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:index, :show, :update_rewards]
  before_action :set_pack_record, only: [:edit, :update, :show, :destroy, :update_rewards]
  
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
    update_rewards(@user)
    respond_to do |format|
      if @pack_record.save
        UserMailer.new_work_email(@user, @pack).deliver_now
        flash[:success] = "Pack Record was created successfully."
        format.js { redirect_turbo employer_view_path}
      else
        format.js { render partial: 'shared/ajax_form_errors', locals: {model: @pack_record}, status: 500 }
      end
    end
  end

  def edit
  end
  
  def update
    @user = User.find(@pack_record.user_id)
    update_rewards(@user)
    respond_to do |format|
      if @pack_record.update_attributes pack_record_params
        flash[:success] = "Pack Record was updated successfully."
        format.js {redirect_turbo employer_view_path}
      else
        format.js { render partial: 'shared/ajax_form_errors', locals: {model: @pack_records}, status: 500 }
      end
    end
  end

  def destroy
    @pack_record.destroy
    redirect_to employer_view_path
  end


  private

    def pack_record_params
      params.require(:pack_record).permit(:pack_id, :user_id, :status, :start_date, :posting_number, :score, :due_date, :comment)
    end
    
    def set_pack_record
      @pack_record = PackRecord.find params[:id] rescue nil
      return not_found! unless @pack_record
    end
    
    def set_user
      @user = User.find params[:user_id] rescue nil
      return not_found! unless @user
    end

    def update_rewards(user)
      @user = user
      @pack_record.reward = @pack_record.calculate_reward(@user, @pack_record.score, @pack_record)
      binding.pry
      @user.rewards += @pack_record.reward
      @user.save
    end
end