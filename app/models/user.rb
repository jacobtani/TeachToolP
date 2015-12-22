class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :children, class_name: "User", foreign_key: "parent_id", dependent: :destroy
  belongs_to :parent, class_name: "User" 
  has_many :pack_records, dependent: :destroy
  has_many :enrolments, dependent: :destroy
  has_many :subjects, through: :enrolments, source: :subject
  enum status: [:ACTIVE, :SUSPENDED, :CANCELLED, :CANCELLED_TRIAL]
  scope :students, -> { where(role: 'student') }
  scope :all_parents, -> { where(role: 'parent') }
  scope :admins, -> { where(role: 'admin') }
  scope :employees, -> { where(role: 'employee') }
  validates_uniqueness_of :email, message: "is already taken"
  
  def calculate_total_fees (user)
    total_fees = 0
    subject_enrolment_fees = calculate_subject_enrolment_fees(user)
    user.total_fees += subject_enrolment_fees
    user.save
    total_fees
  end

  def calculate_subject_enrolment_fees(user)
    subject_enrolment_fees = 0
    if user.role == 'student' && user.enrolments.present?
      user.enrolments.each do |enrolment| 
        subject_enrolment_fees+= enrolment.fees
      end
    end
    subject_enrolment_fees
  end

  def full_name
    "#{first_name} #{surname}"
  end

  def needs_suspension?
    self.pack_records.where(status: 0).count >= 2
  end

  def validate_rewards(user)
    if Date.today == user.activation_date + 6.months
      user.rewards = 0.00
      user.activation_date = Date.today
      user.save 
    elsif user.activation_date + 5.months == Date.today
      UserMailer.reward_expiry_reminder(user).deliver_now
    end 
  end

end