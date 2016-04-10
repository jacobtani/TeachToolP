require 'test_helper'

class PackRecordsControllerTest < ActionController::TestCase

  describe "Pack Records Controller Tests" do
    let(:admin) { users(:admin_user) }
    let(:employee) { users(:employee_user) }
    let(:parent) { users(:jj_parent) }
    let(:student) { users(:iain_student) }
    let(:english) { subjects(:english) }
    let(:maths_pack) { packs(:five_advanced_m) }
    let(:english_pack) { packs(:five_junior_e) }
    let(:pack_record_iain) { pack_records(:iain_pack_record_one) }
    let(:pack_record_tj) { pack_records(:tj_pack_record_one) }

    describe "actions by a non logged in user" do

      it "doesn't allow pack record to be created when not logged in" do
        post :create, pack_record: { user_id: student.id, start_date: Date.today, due_date: Date.today + 1.week, pack_id: maths_pack.id, status: 'DISPATCHED' }
        assert_response 302
        @controller.instance_variable_get('@pack_record').must_equal nil
      end

      it "redirect non logged in user  when trying to update a pack record" do
       	patch :update, id: pack_record_tj, pack_record: { id: pack_record_tj.id, status: 'RECEIVED' }
        assert_response 302
        @controller.instance_variable_get('@pack_record').must_equal nil
      end

      it "redirect user when trying to delete a pack record" do
        assert_difference ->{ PackRecord.all.count }, 0 do
          delete :destroy, id: pack_record_iain
        end
        assert_response :redirect
      end

     it "should not display pack records if not logged in" do
        get :index
        assert_response 302
        assert_nil assigns(:pack_records)
     end
   end

   describe "actions by a student" do

     before do
       sign_in student
     end

     it "for student doesn't allow pack record to be created" do
       post :create, pack_record: { user_id: student.id, start_date: Date.today, due_date: Date.today + 1.week, pack_id: maths_pack.id, status: 'DISPATCHED' }
       assert_response 302
       @controller.instance_variable_get('@pack_record').must_equal nil
     end

     it "for student, redirect user when update pack record" do
       patch :update, id: pack_record_tj, pack_record: { id: pack_record_tj.id, status: 'RECEIVED' }
       assert_response 302
       @controller.instance_variable_get('@pack_record').status.must_equal 'DISPATCHED'
     end

     it "for student redirect user when trying to delete pack record" do
       assert_difference ->{ PackRecord.all.count }, 0 do
         delete :destroy, id: pack_record_iain
       end
       assert_response :redirect
     end

     it "a student can see their pack records" do
       get :index, user_id: student.id
       assert_response 200
       assert_not_nil assigns(:pack_records)
     end

   end

   describe "actions by an parent" do

     before do
       sign_out student
       sign_in parent
     end

     it "for parent doesn't allow pack record to be created" do
       post :create, pack_record: { user_id: student.id, start_date: Date.today, due_date: Date.today + 1.week, pack_id: maths_pack.id, status: 'DISPATCHED' }
       assert_response 302
       @controller.instance_variable_get('@pack_record').must_equal nil
     end

     it "for parent, redirect user when update pack record" do
       patch :update, id: pack_record_tj, pack_record: { id: pack_record_tj.id, status: 'RECEIVED' }
       assert_response 302
       @controller.instance_variable_get('@pack_record').status.must_equal 'DISPATCHED'
     end

     it "for parent redirect user when trying to delete pack record" do
       post :create, pack_record: { user_id: student.id, start_date: Date.today, due_date: Date.today + 1.week, pack_id: maths_pack.id, status: 'DISPATCHED' }
       assert_difference ->{ PackRecord.all.count }, 0 do
        delete :destroy, id: pack_record_iain
       end
       assert_response :redirect
     end

     it "a parent can see the pack records of all their kids" do
       get :index, user_id: student.id
       assert_response 200
       assert_not_nil assigns(:pack_records)
     end

   end

   describe "actions by an employee" do

     before do
       sign_out parent
       sign_in employee
     end

     it "an employee can add new valid pack record" do
       post :create, pack_record: { user_id: student.id, start_date: Date.today, due_date: Date.today + 1.week, pack_id: maths_pack.id, status: 'DISPATCHED' }
       assert_response 302
       assert_not_nil assigns (:pack_record)
       @controller.instance_variable_get('@pack_record').status.must_equal 'DISPATCHED'
       @controller.instance_variable_get('@pack_record').pack_id.must_equal maths_pack.id
     end

     it "an employee can add new invalid pack record" do
       post :create, pack_record: { user_id: student.id, start_date: Date.today, due_date: Date.today + 1.week, pack_id: maths_pack.id, status: nil }
       assert_includes response.body, "blank"
       assert_response 200
       assert_includes response.header['Content-Type'], 'text/html'
       assert_not_nil assigns (:pack_record)
       @controller.instance_variable_get('@pack_record').status.must_equal nil
       @controller.instance_variable_get('@pack_record').pack_id.must_equal maths_pack.id
     end

     it "an employee can update a pack record" do
       patch :update, id: pack_record_tj, pack_record: { id: pack_record_tj.id, status: 'RECEIVED' }
       assert_response 302
       @controller.instance_variable_get('@pack_record').status.must_equal 'RECEIVED'
     end

     it "an employee can update an invalid pack record" do
       patch :update, id: pack_record_tj, pack_record: { id: pack_record_tj.id, status: nil }
       assert_includes response.body, "blank"
       assert_response 200
       assert_includes response.header['Content-Type'], 'text/html'
       @controller.instance_variable_get('@pack_record').status.must_equal nil
     end

     it "an employee can delete a pack record" do
       post :create, pack_record: { user_id: student.id, start_date: Date.today, due_date: Date.today + 1.week, pack_id: maths_pack.id, status: 'DISPATCHED' }
       assert_difference ->{ PackRecord.all.count }, -1 do
        delete :destroy, id: pack_record_iain
       end
       assert_response :redirect
     end

     it "an employee can view all pack records" do
       get :index, user_id: employee.id
       assert_response 200
       assert_not_nil assigns(:pack_records)
     end

     it "sends work missing email correctly" do 
       get :work_missing_email
       assert_response 302
       assert_equal flash[:success], "Work missing emails are sent"
     end

   end

   describe "actions by an admin" do

     before do
       sign_out employee
       sign_in admin
     end

     it "for admin can create pack record " do
       assert_difference 'ActionMailer::Base.deliveries.size', +1 do
         post :create, pack_record: { user_id: student.id, start_date: Date.today, due_date: Date.today + 1.week, pack_id: maths_pack.id, status: 'DISPATCHED' }
       end
       assert_response 302
       assert_not_nil assigns (:pack_record)
       @controller.instance_variable_get('@pack_record').status.must_equal 'DISPATCHED'
       @controller.instance_variable_get('@pack_record').pack_id.must_equal maths_pack.id
     end

     it "for admin, can update pack record" do
       patch :update, id: pack_record_tj, pack_record: { id: pack_record_tj.id, status: 'RECEIVED' }
       assert_response 302
       @controller.instance_variable_get('@pack_record').status.must_equal 'RECEIVED'
     end

     it "for admin can delete pack record" do
       assert_difference ->{ PackRecord.all.count }, -1 do
         delete :destroy, id: pack_record_iain
       end
       assert_response :redirect
     end

     it "for admin can display all pack records" do
       get :index, user_id: admin.id
       assert_response 200
       assert_not_nil assigns(:pack_records)
     end

   end

 end

end