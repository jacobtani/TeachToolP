require 'test_helper'

class OffersControllerTest < ActionController::TestCase

  describe "Offers Controller Tests" do
    let(:admin) { users(:admin_user) }
    let(:employee) { users(:employee_user) }
    let(:parent) { users(:jj_parent) }
    let(:student) { users(:iain_student) }
    let(:english) { subjects(:english) }
    let(:english_offer) { offers(:offer_english) }
    let(:maths_offer) { offers(:offer_maths) }

    describe "actions by a non logged in user" do

      it "doesn't allow offer to be created when not logged in" do
        post :create, offer: { offer_name: 'Special English Offer', offer_description: 'Only valid for 2 months', start_date: DateTime.now, end_date: DateTime.now + 2.months, discount_monthly: 30, subject_id: english.id }
        assert_response 302
        @controller.instance_variable_get('@offer').must_equal nil
      end

      it "rredirect user  when trying to update a offer" do
        patch :update, id: english_offer, offer: { offer_id: Offer.first }
        assert_response 302
        @controller.instance_variable_get('@offer').must_equal nil
      end

      it "redirect user when trying to delete a offer" do
        assert_difference ->{ Offer.all.count }, 0 do
          delete :destroy, id: maths_offer
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
       post :create, offer: { offer_name: 'Special English Offer', offer_description: 'Only valid for 2 months', start_date: DateTime.now, end_date: DateTime.now + 2.months, discount_monthly: 30, subject_id: english.id }
       assert_response 302
       @controller.instance_variable_get('@offer').must_equal nil
     end

     it "for student, redirect user when update offer" do
       patch :update, id: english_offer, offer: { offer_id: Offer.first, discount_monthly: 100 }
       assert_response 302
       @controller.instance_variable_get('@offer').discount_monthly.must_equal 40
     end

     it "for student redirect user when trying to delete offer" do
       assert_difference ->{ Offer.all.count }, 0 do
         delete :destroy, id: maths_offer
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
       post :create, offer: { offer_name: 'Special English Offer', offer_description: 'Only valid for 2 months', start_date: DateTime.now, end_date: DateTime.now + 2.months, discount_monthly: 30, subject_id: english.id }
       assert_response 302
       @controller.instance_variable_get('@offer').must_equal nil
     end

     it "for parent, redirect user when update offer" do
       patch :update, id: english_offer, offer: { offer_id: Offer.first, discount_monthly: 100 }
       assert_response 302
       @controller.instance_variable_get('@offer').discount_monthly.must_equal 40
     end

     it "for parent redirect user when trying to delete offer" do
       assert_difference ->{ Offer.all.count }, 0 do
         delete :destroy, id: maths_offer
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
       post :create, offer: { offer_name: 'Special English Offer', offer_description: 'Only valid for 2 months', start_date: DateTime.now, end_date: DateTime.now + 2.months, discount_monthly: 30, subject_id: english.id }
       assert_response 302
       @controller.instance_variable_get('@offer').must_equal nil
     end

     it "for employee, redirect user when update offer" do
       patch :update, id: english_offer, offer: { offer_id: Offer.first, discount_monthly: 100 }
       assert_response 302
       @controller.instance_variable_get('@offer').discount_monthly.must_equal 40
     end

     it "for employee redirect user when trying to delete offer" do
       assert_difference ->{ Offer.all.count }, 0 do
         delete :destroy, id: maths_offer
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
       post :create, offer: { offer_name: 'Special English Offer', offer_description: 'Only valid for 2 months', start_date: DateTime.now, end_date: DateTime.now + 2.months, discount_monthly: 30, subject_id: english.id }
       assert_response 302
       @controller.instance_variable_get('@offer').offer_name.must_equal 'Special English Offer'
       @controller.instance_variable_get('@offer').offer_description.must_equal'Only valid for 2 months'
       @controller.instance_variable_get('@offer').discount_monthly.must_equal 30
     end

     it "an admin cannot add new invalid offer" do
       post :create, offer: { offer_name: 'My Offer', offer_description: 'My Exclusive best offer', start_date: DateTime.now, discount_enrolment: 50, subject_id: english.id }
       assert_includes response.body, "blank"
       assert_response 200
       assert_includes response.header['Content-Type'], 'text/html'
       @controller.instance_variable_get('@offer').offer_name.must_equal 'My Offer'
       @controller.instance_variable_get('@offer').discount_enrolment.must_equal 50
     end

     it "admin can update a offer" do
       patch :update, id: english_offer, offer: { offer_id: Offer.first, discount_monthly: 100 }
       assert_response 302
       @controller.instance_variable_get('@offer').discount_monthly.must_equal 100
     end

    it "admin can update an invalid offer" do
       patch :update, id: english_offer, offer: { offer_id: Offer.first, end_date: nil }
       assert_includes response.body, "blank"
       assert_response 200
       assert_includes response.header['Content-Type'], 'text/html'
       @controller.instance_variable_get('@offer').end_date.must_equal nil
     end

     it "admin can delete an offer" do
       assert_difference ->{ Offer.all.count }, -1 do
        delete :destroy, id: maths_offer
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