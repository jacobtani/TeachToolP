class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :children, class_name: "User", foreign_key: "parent_id", dependent: :destroy
  has_many :pack_records, dependent: :destroy
  has_many :enrolments, dependent: :destroy
  has_many :subjects, through: :enrolments, source: :subject
  belongs_to :parent, class_name: "User" 
  scope :students, -> { where(role: 'student') }
  scope :all_parents, -> { where(role: 'parent') }
  scope :admins, -> { where(role: 'admin') }
  scope :employees, -> { where(role: 'employee') }
  enum status: [:ACTIVE, :SUSPENDED, :CANCELLED, :CANCELLED_TRIAL]
  validates_uniqueness_of :email, message: "is already taken"
  accepts_nested_attributes_for :enrolments, allow_destroy: true

  def full_name
    "#{first_name} #{surname}"
  end

  def privileged?
    role == 'admin' || role == 'employee'
  end

  def admin?
    role == 'admin'
  end

  def parent?
    role == 'parent'
  end

  def student?
    role == 'student'
  end

  def self.update_total_rewards(user)
    total_rewards = 0
    user.pack_records.each {|pr| total_rewards = pr.reward  }
    user.update(rewards: total_rewards)
  end

  def needs_suspension?
    self.pack_records.where(status: 0).count >= 2
  end

  def calculate_total_fees (user)
    total_fees = 0
    subject_enrolment_fees = calculate_subject_enrolment_fees(user)
    user.update(total_fees: subject_enrolment_fees)
    subject_enrolment_fees
  end

  def calculate_subject_enrolment_fees(user)
    subject_enrolment_fees = 0
    if user.role == 'student' && user.enrolments.present?
      user.enrolments.each {|enrolment| subject_enrolment_fees+= enrolment.fees  }
    end
    subject_enrolment_fees
  end

end