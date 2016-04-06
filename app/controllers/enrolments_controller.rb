 class EnrolmentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:index]

  def index
    @enrolments = @user.enrolments
  end

  private

    def set_user
      @user = User.find params[:users_admin_id] 
      return not_found! unless @user
    end

end