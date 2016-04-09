require 'test_helper'

class EnclosuresControllerTest < ActionController::TestCase

  describe "Enclosures Controller Tests" do
    let(:admin) { users(:admin_user) }
    let(:employee) { users(:employee_user) }
    let(:parent) { users(:jj_parent) }
    let(:student) { users(:iain_student) }
    let(:english) { subjects(:english) }
    let(:maths_enclosure) { enclosures(:maths_enclosure) }
    let(:english_enclosure) { enclosures(:english_enclosure) }
    let(:english_pack) { packs(:five_junior_e) }

    describe "actions by a non logged in user" do

      it "doesn't allow enclosure to be created when not logged in" do
        post :create, enclosure: { name: 'Learn Grammar', enclosure_type: 'FREE', pack_id: english_pack.id, barcode: 123455, due_date: Time.now + 1.week, status: 'AVAILABLE' }
        assert_response 302
        @controller.instance_variable_get('@enclosure').must_equal nil
      end

      it "for a non logged in user doesn't allow update enclosure" do
       patch :update, id: maths_enclosure, enclosure: { enclosure_id: maths_enclosure, name: 'Learn Algebra 5th Grade'  }
        assert_response 302
        @controller.instance_variable_get('@enclosure').must_equal nil
      end

      it "redirect user when trying to delete a enclosure" do
        assert_difference ->{ Enclosure.all.count }, 0 do
          delete :destroy, id: maths_enclosure
        end
        assert_response :redirect
      end

     it "should not display enclosures if not logged in" do
        get :index
        assert_response 302
        assert_nil assigns(:enclosures)
     end

   end

   describe "actions by a student" do

     before do
       sign_in student
     end

     it "for student doesn't allow enclosure to be created" do
       post :create, enclosure: { name: 'Learn Grammar', enclosure_type: 'FREE', pack_id: english_pack.id, barcode: 123455, due_date: Time.now + 1.week, status: 'AVAILABLE' }
       assert_response 302
       @controller.instance_variable_get('@enclosure').must_equal nil
     end

     it "for student, redirect user when update enclosure" do
       patch :update, id: maths_enclosure, enclosure: { enclosure_id: maths_enclosure, name: 'Learn Algebra 5th Grade'  }
       assert_response 302
       @controller.instance_variable_get('@enclosure').name.must_equal 'Learn Algebra'
     end

     it "for student redirect user when trying to delete enclosure" do
       assert_difference ->{ Enclosure.all.count }, 0 do
         delete :destroy, id: maths_enclosure
       end
       assert_response :redirect
     end

     it "for student does not display all enclosures" do
       get :index
       assert_response 302
       assert_nil assigns(:enclosures)
     end

   end

   describe "actions by an parent" do

     before do
       sign_out student
       sign_in parent
     end

     it "for parent doesn't allow enclosure to be created" do
       post :create, enclosure: { name: 'Learn Grammar', enclosure_type: 'FREE', pack_id: english_pack.id, barcode: 123455, due_date: Time.now + 1.week, status: 'AVAILABLE' }
       assert_response 302
       @controller.instance_variable_get('@enclosure').must_equal nil
     end

     it "for parent, redirect user when update enclosure" do
       patch :update, id: maths_enclosure, enclosure: { enclosure_id: maths_enclosure, name: 'Learn Algebra 5th Grade'  }
       assert_response 302
       @controller.instance_variable_get('@enclosure').name.must_equal 'Learn Algebra'
     end

     it "for parent redirect user when trying to delete enclosure" do
       assert_difference ->{ Enclosure.all.count }, 0 do
         delete :destroy, id: maths_enclosure
       end
       assert_response :redirect
     end

     it "for parent does display not all enclosures" do
       get :index
       assert_response 302
       assert_nil assigns(:enclosures)
     end

   end

   describe "actions by an employee" do

     before do
       sign_out parent
       sign_in employee
     end

     it "for employee doesn't allow enclosure to be created" do
       post :create, enclosure: { name: 'Learn Grammar', enclosure_type: 'FREE', pack_id: english_pack.id, barcode: 123455, due_date: Time.now + 1.week, status: 'AVAILABLE' }
       assert_response 302
       @controller.instance_variable_get('@enclosure').must_equal nil
     end

     it "for employee, redirect user when update enclosure" do
       patch :update, id: maths_enclosure, enclosure: { enclosure_id: maths_enclosure, name: 'Learn Algebra 5th Grade'  }
       assert_response 302
       @controller.instance_variable_get('@enclosure').name.must_equal 'Learn Algebra'
     end

     it "for employee redirect user when trying to delete enclosure" do
       assert_difference ->{ Enclosure.all.count }, 0 do
         delete :destroy, id: maths_enclosure
       end
       assert_response :redirect
     end

     it "for employee does not display all enclosures" do
       get :index
       assert_response 302
       assert_nil assigns(:enclosures)
     end

   end

   describe "actions by an admin" do

     before do
       sign_out employee
       sign_in admin
     end

     it "an admin can add new valid enclosure" do
       post :create, enclosure: { name: 'Learn Grammar', enclosure_type: 'FREE', pack_id: english_pack.id, barcode: 123455, due_date: Time.now + 1.week, status: 'AVAILABLE' }
       assert_response 302
       @controller.instance_variable_get('@enclosure').name.must_equal 'Learn Grammar'
       @controller.instance_variable_get('@enclosure').enclosure_type.must_equal'FREE'
     end

     it "an admin can't add new invalid enclosure" do
       post :create, enclosure: { enclosure_type: 'FREE', pack_id: english_pack.id, barcode: 123455, due_date: Time.now + 1.week, status: 'AVAILABLE' }
       assert_includes response.body, "blank"
       assert_response 200
       assert_includes response.header['Content-Type'], 'text/html'
       @controller.instance_variable_get('@enclosure').valid?.must_equal false
       @controller.instance_variable_get('@enclosure').enclosure_type.must_equal'FREE'
     end

     it "admin can update a enclosure" do
       patch :update, id: maths_enclosure, enclosure: { enclosure_id: maths_enclosure, name: 'Learn Algebra 5th Grade'  }
       assert_response 302
       @controller.instance_variable_get('@enclosure').name.must_equal 'Learn Algebra 5th Grade'
     end

     it "admin can update an invalid enclosure" do
       patch :update, id: maths_enclosure, enclosure: { enclosure_id: maths_enclosure, name: nil  }
       assert_includes response.body, "blank"
       assert_response 200
       assert_includes response.header['Content-Type'], 'text/html'
       @controller.instance_variable_get('@enclosure').name.must_equal nil
     end

     it "admin can delete an enclosure" do
       assert_difference ->{ Enclosure.all.count }, -1 do
        delete :destroy, id: maths_enclosure
       end
       assert_response :redirect
     end

     it "admin can view all enclosures" do
       get :index
       assert_response 200
       assert_not_nil assigns(:enclosures)
     end

   end

 end

end