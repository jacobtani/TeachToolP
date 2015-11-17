class Message
  include ActiveAttr::Model
  
  attribute :name
  attribute :email
  attribute :content
  attribute :pack_name
  attribute :page_number
  attribute :question_number
  attribute :subject_name
  attribute :message_subject
  
  #validates_format_of :email, :with => /^[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}$/i
  validates_presence_of :message_subject, :content
  validates_length_of :content, :maximum => 500
end