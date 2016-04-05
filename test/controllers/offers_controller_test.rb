require 'test_helper'

class OffersControllerTest < ActionController::TestCase

  describe "Offers Controller Tests" do
    let(:admin) { users(:admin_user) }
    let(:employee) { users(:employee_user) }
    let(:parent) { users(:jj_parent) }
    let(:student) { users(:iain_student) }
    let(:english) { subjects(:english) }
    let(:english_fee) { fees(:monthly_english_fee) }
    let(:maths_fee) { fees(:monthly_maths_fee) }

    describe "actions by a non logged in user" do

      it "doesn't allow offer to be created when not logged in" do
        post :create, offer: { start_date: Date.today, end_date: Date.today + 1.year, amount: 180, fee_type: 1, subject: english }
        assert_response 302
        @controller.instance_variable_get('@offer').must_equal nil
      end

      it "rredirect user  when trying to update a offer" do
        patch :update, id: english_fee, offer: { offer_id: Offer.second }
        assert_response 302
        @controller.instance_variable_get('@offer').must_equal nil
      end

      it "redirect user when trying to delete a offer" do
        assert_difference ->{ Offer.all.count }, 0 do
          delete :destroy, id: maths_fee
        end
        assert_response :redirect
      end
     
     it "should display offers if not logged in" do
        get :index
        assert_response 200
        assert_not_nil assigns(:offers)
     end
   end

   describe "actions by a student" do

     before do
       sign_in student
     end

     it "for student doesn't allow offer to be created" do
       post :create, offer: { start_date: Date.today, end_date: Date.today + 1.year, amount: 180, fee_type: 1, subject: english }
       assert_response 302
       @controller.instance_variable_get('@offer').must_equal nil
     end

     it "for student, redirect user when update offer" do
       patch :update, id: english_fee, offer: { offer_id: Offer.second, amount: 250 }
       assert_response 302
       @controller.instance_variable_get('@offer').amount.must_equal 160
     end

     it "for student redirect user when trying to delete offer" do
       assert_difference ->{ Offer.all.count }, 0 do
         delete :destroy, id: maths_fee
       end
       assert_response :redirect
     end
   
     it "for student does display all offers" do
       get :index
       assert_response 200
       assert_not_nil assigns(:offers)
     end

   end

   describe "actions by an parent" do

     before do
       sign_out student
       sign_in parent
     end

     it "for parent doesn't allow offer to be created" do
       post :create, offer: { start_date: Date.today, end_date: Date.today + 1.year, amount: 180, fee_type: 1, subject: english }
       assert_response 302
       @controller.instance_variable_get('@offer').must_equal nil
     end

     it "for parent, redirect user when update offer" do
       patch :update, id: english_fee, offer: { offer_id: Offer.second, amount: 250 }
       assert_response 302
       @controller.instance_variable_get('@offer').amount.must_equal 160
     end

     it "for parent redirect user when trying to delete offer" do
       assert_difference ->{ Offer.all.count }, 0 do
         delete :destroy, id: maths_fee
       end
       assert_response :redirect
     end
   
     it "for parent does display all offers" do
       get :index
       assert_response 200
       assert_not_nil assigns(:offers)
     end

   end

   describe "actions by an employee" do

     before do
       sign_out parent
       sign_in employee
     end

     it "for employee doesn't allow offer to be created" do
       post :create, offer: { start_date: Date.today, end_date: Date.today + 1.year, amount: 180, fee_type: 1, subject: english }
       assert_response 302
       @controller.instance_variable_get('@offer').must_equal nil
     end

     it "for employee, redirect user when update offer" do
       patch :update, id: english_fee, offer: { offer_id: Offer.second, amount: 250 }
       assert_response 302
       @controller.instance_variable_get('@offer').amount.must_equal 160
     end

     it "for employee redirect user when trying to delete offer" do
       assert_difference ->{ Offer.all.count }, 0 do
         delete :destroy, id: maths_fee
       end
       assert_response :redirect
     end
   
     it "for employee does not display all offers" do
       get :index
       assert_response 200
       assert_not_nil assigns(:offers)
     end

   end
   describe "actions by an admin" do

     before do
       sign_out employee
       sign_in admin 
     end

     it "an admin can add new offer" do
       post :create, offer: { start_date: Date.today, end_date: Date.today + 1.year, amount: 180, fee_type: "MONTHLY", subject: english }
       assert_response 302
       @controller.instance_variable_get('@offer').amount.must_equal 180
       @controller.instance_variable_get('@offer').subject.must_equal @english
       @controller.instance_variable_get('@offer').fee_type.must_equal 'MONTHLY'
     end

     it "admin can update a offer" do
       patch :update, id: english_fee, offer: { offer_id: Offer.second, amount: 250 }
       assert_response 302
       @controller.instance_variable_get('@offer').amount.must_equal 250
     end

     it "admin can delete an offer" do
       assert_difference ->{ Offer.all.count }, -1 do
        delete :destroy, id: maths_fee
       end
       assert_response :redirect
     end
 
     it "admin can view all offers" do
       get :index
       assert_response 200
       assert_not_nil assigns(:offers)
     end
   
   end

 end

end