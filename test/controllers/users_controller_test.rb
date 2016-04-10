require 'test_helper'

class UsersControllerTest < ActionController::TestCase

  describe "Users Controller Tests" do
    let(:admin) { users(:admin_user) }
    let(:employee) { users(:employee_user) }
    let(:parent) { users(:jj_parent) }
    let(:student) { users(:iain_student) }
    let(:tj_student) { users(:tj_student) }
    let(:english) { subjects(:english) }
    let(:english_offer) { offers(:offer_english) }
    let(:maths_offer) { offers(:offer_maths) }

    describe "actions by a non logged in user" do

      it "doesn't allow user to be created when not logged in" do
        post :create, user: { email: 'anita@gmail.com', password: 'iamawesome123', contact_email: 'jj@gmail.com', parent_id: parent.id, first_name: 'Anita', surname: 'Student', role: 'student', postal_address: '5 Lilly Lane', city: 'Alabama', state: 'AL', zip_code: 2011  }
        assert_response 302
        @controller.instance_variable_get('@user').must_equal nil
      end

      it "non logged in user can't update a user" do
        patch :update, id: student, user: { user_id: student.id, surname: 'Bro' }
        assert_response 302
        @controller.instance_variable_get('@user').must_equal nil
      end

      it "redirect user when trying to delete a user" do
        assert_difference ->{ User.all.count }, 0 do
          delete :destroy, id: tj_student
        end
        assert_response :redirect
      end

      it "should not display users if not logged in" do
        get :index
        assert_response 302
        assert_nil assigns(:users)
     end
     
     it "should not display user details if not logged in" do
       get :show, id: student
       assert_response 302
       assert_nil assigns(:user)
     end     

   end

   describe "actions by a student" do

     before do
       sign_in student
     end

     it "for student doesn't allow user to be created" do
       post :create, user: { contact_email: 'jj@gmail.com', parent_id: parent, email: 'anita@gmail.com', password: 'iamawesome123', contact_email: 'jj@gmail.com', first_name: 'Anita', surname: 'Student', role: 'student', postal_address: '5 Lilly Lane', city: 'Alabama', state: 'AL', zip_code: 2011  }
       assert_response 302
       @controller.instance_variable_get('@user').must_equal nil
     end

     it "for student, redirect user when update user" do
       patch :update, id: student, user: { user_id: student.id, surname: 'Bro' }
       assert_response 302
       @controller.instance_variable_get('@user').surname.must_equal 'Awesome'
     end

     it "for student redirect user when trying to delete user" do
       assert_difference ->{ User.all.count }, 0 do
         delete :destroy, id: tj_student
       end
       assert_response :redirect
     end
   
     it "for student does display all users" do
       get :index
       assert_response 302
       assert_nil assigns(:users)
     end

     it "for student should display user details" do
       get :show, id: student
       assert_response 200
       assert_not_nil assigns(:user)
     end     

   end

   describe "actions by an parent" do

     before do
       sign_out student
       sign_in parent
     end

     it "for parent allow student to be created" do
       post :create, user: { contact_email: 'jj@gmail.com', parent_id: parent, email: 'anita@gmail.com', password: 'iamawesome123', contact_email: 'jj@gmail.com', first_name: 'Anita', surname: 'Student', role: 'student', postal_address: '5 Lilly Lane', city: 'Alabama', state: 'AL', zip_code: 2011  }
       assert_response 302
       @controller.instance_variable_get('@user').role.must_equal 'student'
       @controller.instance_variable_get('@user').first_name.must_equal 'Anita'
     end

     it "for parent, allow to update student" do
       patch :update, id: student, user: { user_id: student.id, surname: 'Bro' }
       assert_response 302
       @controller.instance_variable_get('@user').surname.must_equal 'Bro'
     end

     it "for parent allow them to delete student" do
       assert_difference ->{ User.all.count }, -1 do
         delete :destroy, id: tj_student
       end
       assert_response :redirect
     end
   
     it "for parent does display all users" do
       get :index
       assert_response 200
       assert_not_nil assigns(:users)
     end

    it "ends trial correctly" do 
      get :end_trial, id: student
      @controller.instance_variable_get('@user').status.must_equal 'CANCELLED_TRIAL'
    end    

    it "for parent should display user details" do
       get :show, id: parent
       assert_response 200
       assert_not_nil assigns(:user)
    end     
   
   end

   describe "actions by an employee" do

     before do
       sign_out parent
       sign_in employee
     end

     it "for employee allow user to be created" do
       post :create, user: { contact_email: 'jj@gmail.com', parent_id: parent.id , email: 'anita@gmail.com', password: 'iamawesome123', contact_email: 'jj@gmail.com', first_name: 'Anita', surname: 'Student', role: 'student', postal_address: '5 Lilly Lane', city: 'Alabama', state: 'AL', zip_code: 2011  }
       assert_response 302
       @controller.instance_variable_get('@user').role.must_equal 'student'
       @controller.instance_variable_get('@user').first_name.must_equal 'Anita'
     end

     it "for employee, does allow update to user" do
       patch :update, id: student, user: { user_id: student.id, surname: 'Bro' }
       assert_response 302
       @controller.instance_variable_get('@user').surname.must_equal 'Bro'
     end

     it "for employee allow to delete user" do
       assert_difference ->{ User.all.count }, -1 do
         delete :destroy, id: tj_student
       end
       assert_response :redirect
     end
   
     it "for employee does display all users" do
       get :index
       assert_response 200
       assert_not_nil assigns(:users)
     end

     it "for employee should display user details" do
       get :show, id: employee
       assert_response 200
       assert_not_nil assigns(:user)
     end     

   end

   describe "actions by an admin" do

     before do
       sign_out employee
       sign_in admin
     end

     it "new user should render right template" do 
       get :new
       assert_template layout: "layouts/application", partial: "_form"
     end

     it "for admin allow valid user to be created" do
       post :create, user: { parent_id: parent, email: 'anita@gmail.com', password: 'iamawesome123', contact_email: 'jj@gmail.com', first_name: 'Anita', surname: 'Student', role: 'student', postal_address: '5 Lilly Lane', city: 'Alabama', state: 'AL', zip_code: 2011  }
       assert_response 302
       @controller.instance_variable_get('@user').role.must_equal 'student'
       @controller.instance_variable_get('@user').first_name.must_equal 'Anita'
     end

     it "for admin allow invalid user to be created" do
       post :create, user: { contact_email: 'jj@gmail.com', parent_id: parent, first_name: 'Anita', surname: 'Student', role: 'student', postal_address: '5 Lilly Lane', city: 'Alabama', state: 'AL', zip_code: 2011  }
       assert_response 200
       assert_includes response.body, "blank"
       assert_includes response.header['Content-Type'], 'text/html'
       @controller.instance_variable_get('@user').role.must_equal 'student'
       @controller.instance_variable_get('@user').first_name.must_equal 'Anita'
     end

     it "for admin, does allow update to user" do
       patch :update, id: student, user: { user_id: student.id, surname: 'Bro' }
       assert_response 302
       @controller.instance_variable_get('@user').surname.must_equal 'Bro'
     end

     it "for admin, does allow invalid update to user" do
       patch :update, id: student, user: { user_id: student.id, surname: nil }
       assert_response 200
       assert_includes response.body, "blank"
       assert_includes response.header['Content-Type'], 'text/html'
       @controller.instance_variable_get('@user').surname.must_equal nil
     end

     it "for admin allow to delete user" do
       assert_difference ->{ User.all.count }, -1 do
         delete :destroy, id: tj_student
       end
       assert_response :redirect
     end
   
     it "for admin does display all users" do
       get :index
       assert_response 200
       assert_not_nil assigns(:users)
     end

     it "for admin should display user details" do
       get :show, id: admin
       assert_response 200
       assert_not_nil assigns(:user)
    end     

    it "suspends accounts correctly" do 
      assert_difference 'ActionMailer::Base.deliveries.size', +1 do
        get :suspend, id: student
      end
      @controller.instance_variable_get('@user').status.must_equal 'SUSPENDED'
    end 

    it "marks payment received correctly" do 
      get :payment_received, id: student
    end    

    it "enters placement pack correctly" do 
      get :enter_placement_pack, id: student
    end

    it "enters placement pack correctly" do 
      get :login_as, id: student
      assert_equal flash[:success], 'Logged in successfully'
      assert_response 302
    end

    it "nullify rewards correctly" do
      student.update(rewards: 5) 
      get :nullify_rewards, id: student
      student.reload.rewards.must_equal 0
    end    

   end

 end

end