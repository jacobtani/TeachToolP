class Message
  include ActiveAttr::Model
  
  attribute :name
  attribute :email
  attribute :content
  attribute :pack_name
  attribute :page_number
  attribute :question_number
  attribute :subject_name
  
  #validates_format_of :email, :with => /^[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}$/i
  validates_presence_of :pack_name, :page_number, :question_number, :subject_name
  validates_length_of :content, :maximum => 500
end