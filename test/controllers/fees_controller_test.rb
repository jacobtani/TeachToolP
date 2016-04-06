require 'test_helper'

class FeesControllerTest < ActionController::TestCase

  describe "Fees Controller Tests" do
    let(:admin) { users(:admin_user) }
    let(:employee) { users(:employee_user) }
    let(:parent) { users(:jj_parent) }
    let(:student) { users(:iain_student) }
    let(:english) { subjects(:english) }
    let(:english_fee) { fees(:monthly_english_fee) }
    let(:maths_fee) { fees(:monthly_maths_fee) }

    describe "actions by a non logged in user" do

      it "doesn't allow fee to be created when not logged in" do
        post :create, fee: { fee_name: 'English New', start_date: Date.today, end_date: Date.today + 1.year, amount: 180, fee_type: 1, subject: english }
        assert_response 302
        @controller.instance_variable_get('@fee').must_equal nil
      end

      it "rredirect user  when trying to update a fee" do
        patch :update, id: english_fee, fee: { fee_id: Fee.second }
        assert_response 302
        @controller.instance_variable_get('@fee').must_equal nil
      end

      it "redirect user when trying to delete a fee" do
        assert_difference ->{ Fee.all.count }, 0 do
          delete :destroy, id: maths_fee
        end
        assert_response :redirect
      end
     
     it "should display fees if not logged in" do
        get :index
        assert_response 200
        assert_not_nil assigns(:fees)
     end
   end

   describe "actions by a student" do

     before do
       sign_in student
     end

     it "for student doesn't allow fee to be created" do
       post :create, fee: { fee_name: 'English New', start_date: Date.today, end_date: Date.today + 1.year, amount: 180, fee_type: 1, subject: english }
       assert_response 302
       @controller.instance_variable_get('@fee').must_equal nil
     end

     it "for student, redirect user when update fee" do
       patch :update, id: english_fee, fee: { fee_id: Fee.second, amount: 250 }
       assert_response 302
       @controller.instance_variable_get('@fee').amount.must_equal 160
     end

     it "for student redirect user when trying to delete fee" do
       assert_difference ->{ Fee.all.count }, 0 do
         delete :destroy, id: maths_fee
       end
       assert_response :redirect
     end
   
     it "for student does display all fees" do
       get :index
       assert_response 200
       assert_not_nil assigns(:fees)
     end

   end

   describe "actions by an parent" do

     before do
       sign_out student
       sign_in parent
     end

     it "for parent doesn't allow fee to be created" do
       post :create, fee: { fee_name: 'English New', start_date: Date.today, end_date: Date.today + 1.year, amount: 180, fee_type: 1, subject: english }
       assert_response 302
       @controller.instance_variable_get('@fee').must_equal nil
     end

     it "for parent, redirect user when update fee" do
       patch :update, id: english_fee, fee: { fee_id: Fee.second, amount: 250 }
       assert_response 302
       @controller.instance_variable_get('@fee').amount.must_equal 160
     end

     it "for parent redirect user when trying to delete fee" do
       assert_difference ->{ Fee.all.count }, 0 do
         delete :destroy, id: maths_fee
       end
       assert_response :redirect
     end
   
     it "for parent does display all fees" do
       get :index
       assert_response 200
       assert_not_nil assigns(:fees)
     end

   end

   describe "actions by an employee" do

     before do
       sign_out parent
       sign_in employee
     end

     it "for employee doesn't allow fee to be created" do
       post :create, fee: { fee_name: 'English New', start_date: Date.today, end_date: Date.today + 1.year, amount: 180, fee_type: 1, subject: english }
       assert_response 302
       @controller.instance_variable_get('@fee').must_equal nil
     end

     it "for employee, redirect user when update fee" do
       patch :update, id: english_fee, fee: { fee_id: Fee.second, amount: 250 }
       assert_response 302
       @controller.instance_variable_get('@fee').amount.must_equal 160
     end

     it "for employee redirect user when trying to delete fee" do
       assert_difference ->{ Fee.all.count }, 0 do
         delete :destroy, id: maths_fee
       end
       assert_response :redirect
     end
   
     it "for employee does not display all fees" do
       get :index
       assert_response 200
       assert_not_nil assigns(:fees)
     end

   end
   describe "actions by an admin" do

     before do
       sign_out employee
       sign_in admin 
     end

     it "an admin can add new fee" do
       post :create, fee: { fee_name: 'English New', start_date: Date.today, end_date: Date.today + 1.year, amount: 180, fee_type: "MONTHLY", subject: english }
       assert_response 302
       @controller.instance_variable_get('@fee').amount.must_equal 180
       @controller.instance_variable_get('@fee').subject.must_equal @english
       @controller.instance_variable_get('@fee').fee_type.must_equal 'MONTHLY'
     end

     it "admin can update a fee" do
       patch :update, id: english_fee, fee: { fee_id: Fee.second, amount: 250 }
       assert_response 302
       @controller.instance_variable_get('@fee').amount.must_equal 250
     end

     it "admin can delete a fee" do
       assert_difference ->{ Fee.all.count }, -1 do
        delete :destroy, id: maths_fee
       end
       assert_response :redirect
     end
 
     it "admin can view all fees" do
       get :index
       assert_response 200
       assert_not_nil assigns(:fees)
     end
   
   end

 end

end