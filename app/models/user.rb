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
  
  def full_name
    "#{first_name} #{surname}"
  end

  def needs_suspension?
    self.pack_records.where(status: 0).count >= 2
  end

end