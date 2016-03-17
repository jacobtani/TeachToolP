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
  attribute :message_recipient
  attribute :message_recipient_name
  attribute :subject
  
  validates_presence_of :message_subject
end