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
  #enum role: [:PARENT, :STUDENT, :EMPLOYER, :ADMIN]
  enum status: [:ACTIVE, :SUSPENDED, :CANCELLED]

  def calculate_fees (user)
    total_fees = 0
    if user.role == 'student' && user.enrolments.present?
      user.enrolments.each do |enrolment| 
        total_fees+= enrolment.fees
      end
    end
    total_fees
  end

  def full_name
    "#{first_name} #{surname}"
  end

  def calculate_total_rewards(user)
    rewards_value = 0.0
    if user.role == 'student' && user.pack_records.present?
      user.pack_records.each do |pack_record| 
        rewards_value+= pack_record.reward
      end
      rewards_value
    end

  end

  def needs_suspension?
    self.pack_records.where(status: 0).count >= 2
  end

end
