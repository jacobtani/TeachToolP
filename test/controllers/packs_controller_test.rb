require 'test_helper'

class PacksControllerTest < ActionController::TestCase

  describe "Packs Controller Tests" do
    let(:admin) { users(:admin_user) }
    let(:employee) { users(:employee_user) }
    let(:parent) { users(:jj_parent) }
    let(:student) { users(:iain_student) }
    let(:english) { subjects(:english) }
    let(:maths_pack) { packs(:five_advanced_m) }
    let(:english_pack) { packs(:five_junior_e) }

    describe "actions by a non logged in user" do

      it "doesn't allow pack to be created when not logged in" do
        post :create, pack: { name: '6++', description: 'Advanced pack for sixth graders in english', subject: english }
        assert_response 302
        @controller.instance_variable_get('@pack').must_equal nil
      end

      it "rredirect user  when trying to update a pack" do
        patch :update, id: english_pack, pack: { pack_id: Pack.first, name: '5-- English'  }
        assert_response 302
        @controller.instance_variable_get('@pack').must_equal nil
      end

      it "redirect user when trying to delete a pack" do
        assert_difference ->{ Pack.all.count }, 0 do
          delete :destroy, id: maths_pack
        end
        assert_response :redirect
      end

     it "should not display packs if not logged in" do
        get :index
        assert_response 302
        assert_nil assigns(:packs)
     end
   end

   describe "actions by a student" do

     before do
       sign_in student
     end

     it "for student doesn't allow pack to be created" do
       post :create, pack: { name: '6++', description: 'Advanced pack for sixth graders in english', subject_id: english.id }
       assert_response 302
       @controller.instance_variable_get('@pack').must_equal nil
     end

     it "for student, redirect user when update pack" do
       patch :update, id: english_pack, pack: { pack_id: Pack.first, name: '5-- English'  }
       assert_response 302
       @controller.instance_variable_get('@pack').name.must_equal '5--'
     end

     it "for student redirect user when trying to delete pack" do
       assert_difference ->{ Pack.all.count }, 0 do
         delete :destroy, id: maths_pack
       end
       assert_response :redirect
     end

     it "for student does not display all packs" do
       get :index
       assert_response 302
       assert_nil assigns(:packs)
     end

   end

   describe "actions by an parent" do

     before do
       sign_out student
       sign_in parent
     end

     it "for parent doesn't allow pack to be created" do
       post :create, pack: { name: '6++', description: 'Advanced pack for sixth graders in english', subject_id: english.id }
       assert_response 302
       @controller.instance_variable_get('@pack').must_equal nil
     end

     it "for parent, redirect user when update pack" do
       patch :update, id: english_pack, pack: { pack_id: Pack.first, nane: '5-- English'  }
       assert_response 302
       @controller.instance_variable_get('@pack').name.must_equal '5--'
     end

     it "for parent redirect user when trying to delete pack" do
       assert_difference ->{ Pack.all.count }, 0 do
         delete :destroy, id: maths_pack
       end
       assert_response :redirect
     end

     it "for parent does display not all packs" do
       get :index
       assert_response 302
       assert_nil assigns(:packs)
     end

   end

   describe "actions by an employee" do

     before do
       sign_out parent
       sign_in employee
     end

     it "for employee doesn't allow pack to be created" do
       post :create, pack: { name: '6++', description: 'Advanced pack for sixth graders in english', subject_id: english.id }
       assert_response 302
       @controller.instance_variable_get('@pack').must_equal nil
     end

     it "for employee, redirect user when update pack" do
       patch :update, id: english_pack, pack: { pack_id: Pack.first, name: '5-- English'  }
       assert_response 302
       @controller.instance_variable_get('@pack').name.must_equal '5--'
     end

     it "for employee redirect user when trying to delete pack" do
       assert_difference ->{ Pack.all.count }, 0 do
         delete :destroy, id: maths_pack
       end
       assert_response :redirect
     end

     it "for employee does not display all packs" do
       get :index
       assert_response 302
       assert_nil assigns(:packs)
     end

   end

   describe "actions by an admin" do

     before do
       sign_out employee
       sign_in admin
     end

     it "new pack should render right template" do 
       get :new
       assert_template layout: "layouts/application", partial: "_form"
     end

     it "an admin can add new pack" do
       post :create, pack: { name: '6++', description: 'Advanced pack for sixth graders in english', subject_id: english.id }
       assert_response 302
       @controller.instance_variable_get('@pack').name.must_equal '6++'
       @controller.instance_variable_get('@pack').description.must_equal'Advanced pack for sixth graders in english'
     end

     it "an admin can add new invalid pack" do
       post :create, pack: { description: 'Advanced pack for seventh graders in english', subject_id: english.id }
       assert_includes response.body, "blank"
       assert_response 200
       assert_includes response.header['Content-Type'], 'text/html'
       @controller.instance_variable_get('@pack').description.must_equal'Advanced pack for seventh graders in english'
     end

     it "admin can update a pack" do
       patch :update, id: english_pack, pack: { pack_id: Pack.first, name: '5-- English'  }
       assert_response 302
       @controller.instance_variable_get('@pack').name.must_equal '5-- English'
     end

     it "admin can update an invalid pack" do
       patch :update, id: english_pack, pack: { pack_id: Pack.first, name: nil  }
       assert_includes response.body, "blank"
       assert_response 200
       assert_includes response.header['Content-Type'], 'text/html'
       @controller.instance_variable_get('@pack').name.must_equal nil
     end

     it "admin can delete an pack" do
       assert_difference ->{ Pack.all.count }, -1 do
        delete :destroy, id: maths_pack
       end
       assert_response :redirect
     end

     it "admin can view all packs" do
       get :index
       assert_response 200
       assert_not_nil assigns(:packs)
     end

   end

 end

end