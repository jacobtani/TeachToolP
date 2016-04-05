require 'test_helper'

class SubjectsControllerTest < ActionController::TestCase

  describe "Subjects Controller Tests" do
    let(:admin) { users(:admin_user) }
    let(:employee) { users(:employee_user) }
    let(:parent) { users(:jj_parent) }
    let(:student) { users(:iain_student) }
    let(:maths) { subjects(:maths) }
    let(:english) { subjects(:english) }

    describe "actions by a non logged in user" do

      it "doesn't allow subject to be created when not logged in" do
        post :create, subject: { subject_name: 'Science', lowest_grade_taught: 1, highest_grade_taught: 7 }
        assert_response 302
        @controller.instance_variable_get('@subject').must_equal nil
      end

      it "rredirect user  when trying to update a subject" do
        patch :update, id: english, subject: { subject_id: english.id }
        assert_response 302
        @controller.instance_variable_get('@subject').must_equal nil
      end

      it "redirect user when trying to delete a subject" do
        assert_difference ->{ Subject.all.count }, 0 do
          delete :destroy, id: english
        end
        assert_response :redirect
      end
     
     it "should not get any of the subjects" do
        get :index
        assert_response :redirect
        assert_nil assigns(:subjects)
     end
   end

   describe "actions by a student" do

     before do
       sign_in student
     end

     it "for student doesn't allow subject to be created" do
       post :create, subject: { subject_name: 'Science', lowest_grade_taught: 1, highest_grade_taught: 7 }
       assert_response 302
       @controller.instance_variable_get('@subject').must_equal nil
     end

     it "for student, redirect user when update subject" do
       patch :update, id: english, subject: { subject_name: 'Science', lowest_grade_taught: 3, highest_grade_taught: 7 }
       assert_response 302
       @controller.instance_variable_get('@subject').lowest_grade_taught.must_equal 1
     end

     it "for student redirect user when trying to delete subject" do
       assert_difference ->{ Subject.all.count }, 0 do
         delete :destroy, id: english
       end
       assert_response :redirect
     end
   
     it "for employee does not display all subjects" do
       get :index
       assert_response 302
       assert_nil assigns(:subjects)
     end

   end

   describe "actions by an parent" do

     before do
       sign_out student
       sign_in parent
     end

     it "for parent doesn't allow subject to be created" do
       post :create, subject: { subject_name: 'Science', lowest_grade_taught: 1, highest_grade_taught: 7 }
       assert_response 302
       @controller.instance_variable_get('@subject').must_equal nil
     end

     it "for parent, redirect user when update subject" do
       patch :update, id: english, subject: { subject_name: 'Science', lowest_grade_taught: 3, highest_grade_taught: 7 }
       assert_response 302
       @controller.instance_variable_get('@subject').lowest_grade_taught.must_equal 1
     end

     it "for parent redirect user when trying to delete subject" do
       assert_difference ->{ Subject.all.count }, 0 do
         delete :destroy, id: english
       end
       assert_response :redirect
     end
   
     it "for parent does not display all subjects" do
       get :index
       assert_response 302
       assert_nil assigns(:subjects)
     end

   end

   describe "actions by an employee" do

     before do
       sign_out parent
       sign_in employee
     end

     it "for employee doesn't allow subject to be created" do
       post :create, subject: { subject_name: 'Science', lowest_grade_taught: 1, highest_grade_taught: 7 }
       assert_response 302
       @controller.instance_variable_get('@subject').must_equal nil
     end

     it "for employee, redirect user when update subject" do
       patch :update, id: english, subject: { subject_name: 'Science', lowest_grade_taught: 3, highest_grade_taught: 7 }
       assert_response 302
       @controller.instance_variable_get('@subject').lowest_grade_taught.must_equal 1
     end

     it "for employee redirect user when trying to delete subject" do
       assert_difference ->{ Subject.all.count }, 0 do
         delete :destroy, id: english
       end
       assert_response :redirect
     end
   
     it "for employee does not display all subjects" do
       get :index
       assert_response 302
       assert_nil assigns(:subjects)
     end

   end
   describe "actions by an admin" do

     before do
       sign_out employee
       sign_in admin 
     end

     it "an admin can add new subject" do
       post :create, subject: { subject_name: 'Science', lowest_grade_taught: 1, highest_grade_taught: 7 }
       assert_response 302
       @controller.instance_variable_get('@subject').subject_name.must_equal 'Science'
       @controller.instance_variable_get('@subject').lowest_grade_taught.must_equal 1
       @controller.instance_variable_get('@subject').highest_grade_taught.must_equal 7
     end

     it "admin can update a subject" do
       patch :update, id: english, subject: { subject_name: 'Science', lowest_grade_taught: 3, highest_grade_taught: 7 }
       assert_response 302
       @controller.instance_variable_get('@subject').lowest_grade_taught.must_equal 3
     end

     it "admin can delete a subject" do
       assert_difference ->{ Subject.all.count }, -1 do
        delete :destroy, id: english
       end
       assert_response :redirect
     end
 
     it "admin can view all subjects" do
       get :index
       assert_response 200
       assert_not_nil assigns(:subjects)
     end
   
   end

 end

end