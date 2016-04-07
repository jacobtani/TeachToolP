require 'test_helper'

class EnrolmentsControllerTest < ActionController::TestCase

  describe "Enrolments Controller Tests" do
    let(:admin) { users(:admin_user) }
    let(:employee) { users(:employee_user) }
    let(:parent) { users(:jj_parent) }
    let(:student) { users(:iain_student) }
    let(:maths) { subjects(:maths) }
    let(:english) { subjects(:english) }

    describe "actions by a non logged in user" do

     it "should not get any of the enrolments" do
        get :index, users_admin_id: 0
        assert_response 302
        assert_nil assigns(:enrolments)
     end

   end

   describe "actions by a student" do

     before do
       sign_in student
     end

     it "for student does display all  user's enrolments" do
       get :index, users_admin_id: student.id
       assert_response 200
       assert_not_nil assigns(:enrolments)
     end

   end

   describe "actions by an parent" do

     before do
       sign_out student
       sign_in parent
     end

     it "for parent does display all of a user's enrolments" do
       get :index, users_admin_id: parent.id
       assert_response 200
       assert_not_nil assigns(:enrolments)
     end

   end

   describe "actions by an employee" do

     before do
       sign_out parent
       sign_in employee
     end

     it "for employee does display all user's enrolments" do
       get :index, users_admin_id: employee.id
       assert_response 200
       assert_not_nil assigns(:enrolments)
     end

   end

   describe "actions by an admin" do

     before do
       sign_out employee
       sign_in admin
     end

     it "admin can view all user's enrolments" do
       get :index, users_admin_id: admin.id
       assert_response 200
       assert_not_nil assigns(:enrolments)
     end

   end

 end

end