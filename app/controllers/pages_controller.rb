class PagesController < ApplicationController
  before_action :ensure_admin, only: [:admin]
  before_action :ensure_privileged, only: [:employee_view]
  before_action :ensure_parent, only: [:parent_summary]
  before_action :ensure_student, only: [:student_view]

  def home
  end

  def about
  end

  def fees_offers
  end

  def delivery_approach
  end
 
  def contact
  end

  def admin
  end

  def communications
  end
  
  def background
  end

  def expected_roles
  end

  def historical_view
  end

  def questions
  end

  def terms_conditions
  end

  def mission
  end

  def why_extend
  end

  def parent_summary
  end

  def employee_view
  end

  def student_view
  end

  def parent_student_view
  end

end