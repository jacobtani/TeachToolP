require 'test_helper'

class MessagesControllerTest < ActionController::TestCase

  describe "Messages Controller Tests" do
    let(:admin) { users(:admin_user) }
    let(:employee) { users(:employee_user) }
    let(:parent) { users(:jj_parent) }
    let(:student) { users(:iain_student) }
    let(:english) { subjects(:english) }
    let(:english_offer) { offers(:offer_english) }
    let(:maths_offer) { offers(:offer_maths) }
    let(:maths_pack) { packs(:five_advanced_m) }
    let(:english_pack) { packs(:five_junior_e) }

   describe "actions by a student" do

     before do
       sign_in student
     end

     it "for student can send student help required email" do
       get :student_help_required, id: student.id
       assert_includes response.header['Content-Type'], 'text/html'
       assert_response 200
       @controller.instance_variable_get('@message').must_equal Message.new
       assert_difference 'ActionMailer::Base.deliveries.size', +1 do
         post :create, message: { subject_id: english.id, pack_id: english_pack.id, question_number: 8, page_number: 2, message_subject: 'STUDENT NEEDS HELP', content: 'I am really stuck please help me' }
       end
     end

     it "for student can send redeem rewards email" do
       get :redeem_reward, id: student.id
       assert_includes response.header['Content-Type'], 'text/html'
       assert_response 302
       assert_not_nil assigns(:student)
       student.reload.rewards.must_equal 0
     end

   end

   describe "actions by an parent" do

     before do
       sign_out student
       sign_in parent
     end

     it "for parent can send parent help required email" do
       get :parent_help_required, id: parent.id
       assert_includes response.header['Content-Type'], 'text/html'
       assert_response 200
       @controller.instance_variable_get('@message').must_equal Message.new
       assert_difference 'ActionMailer::Base.deliveries.size', +1 do
         post :create, message: { child: student.id, subject_id: english.id, pack_id: english_pack.id, question_number: 5, page_number: 2, message_subject: 'PARENT NEEDS HELP', content: 'I need help' }
       end
     end

     it "for parent can send missing pack email" do
       get :missing_pack, id: parent.id
       assert_includes response.header['Content-Type'], 'text/html'
       assert_response 200
       @controller.instance_variable_get('@message').must_equal Message.new
       assert_difference 'ActionMailer::Base.deliveries.size', +1 do
         post :create, message: { child: student.id, subject_id: english.id, pack_id: english_pack.id, message_subject: 'MISSING PACK/WORK', content: 'I am missing my pack have not received' }
       end
     end

     it "for parent can send general parent enquiry email" do
       get :general_parent_enquiry, id: parent.id
       assert_includes response.header['Content-Type'], 'text/html'
       assert_response 200
       @controller.instance_variable_get('@message').must_equal Message.new
       assert_difference 'ActionMailer::Base.deliveries.size', +1 do
         post :create, message: { message_subject: 'GENERAL CORRESPONDENCE', content: 'I am not that happy with education' }
       end
     end

     it "for parent can send payment related enquiry email" do
       get :payment_related_enquiry, id: parent.id
       assert_includes response.header['Content-Type'], 'text/html'
       assert_response 200
       @controller.instance_variable_get('@message').must_equal Message.new
       assert_difference 'ActionMailer::Base.deliveries.size', +1 do
         post :create, message: { child: student.id, subject_id: english.id, message_subject: 'PAYMENT RELATED', content: 'Have you received my payment?' }
       end
     end

     it "for parent can send recommend us email" do
       get :recommend_us, id: parent.id
       assert_includes response.header['Content-Type'], 'text/html'
       assert_response 200
       @controller.instance_variable_get('@message').must_equal Message.new
       assert_difference 'ActionMailer::Base.deliveries.size', +1 do
         post :create, message: {  message_subject: 'RECOMMEND US', message_recipient_name: 'Charles', message_recipient: 'charles@gmail.com'  }
       end
     end

    it "cancel account correctly" do 
      get :cancel_account, user_id: student
      @controller.instance_variable_get('@user').status.must_equal 'CANCELLED'
      @controller.instance_variable_get('@message').must_equal Message.new
      assert_difference 'ActionMailer::Base.deliveries.size', +2 do
        post :create, message: { child: student, message_subject: 'TERMINATED ACCOUNT', content: 'Financial Reasons' }, user: { user_id: student.id }
      end
    end

   end

   describe "actions by an employee" do

     before do
       sign_out parent
       sign_in employee
     end

     it "for employee can send email to user" do
       get :send_user_message, user_id: parent.id
       assert_includes response.header['Content-Type'], 'text/html'
       assert_response 200
       @controller.instance_variable_get('@message').must_equal Message.new
       assert_difference 'ActionMailer::Base.deliveries.size', +1 do
         post :create, message: { message_recipient_name: 'George', message_recipient: 'george@gmail.com', message_subject: 'SEND EMAIL TO USER', content: 'I want to talk about your missing pack related enquiry' }
       end
     end

     it "for employee can send missing payment email to user" do
       get :missing_payment, user_id: student.id
       assert_includes response.header['Content-Type'], 'text/html'
       assert_response 302
     end
   
   end

 end

end