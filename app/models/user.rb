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

  def calculate_fees (user)
    total_fees = 0
    if user.role == 'student' && user.enrolments.present?
      user.enrolments.each do |enrolment| 
        total_fees+= enrolment.fees
      end
      total_fees
    end
  end

  def full_name
    "#{first_name} #{surname}"
  end

end
