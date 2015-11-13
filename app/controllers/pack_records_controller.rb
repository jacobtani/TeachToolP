class PackRecordsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:index, :show]
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
    @user = @pack_record.user_id
    @pack_record.reward = @pack_record.calculate_reward(@user, @pack_record.score, @pack_record)
   # binding.pry
    respond_to do |format|
      if @pack_record.save
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
      params.require(:pack_record).permit(:pack_id, :user_id, :status, :start_date, :score, :due_date, :comment)
    end
    
    def set_pack_record
      @pack_record = PackRecord.find params[:id] rescue nil
      return not_found! unless @pack_record
    end
    
    def set_user
      @user = User.find params[:user_id] rescue nil
      return not_found! unless @user
    end

end