require 'test_helper'

class SubjectsControllerTest < ActionController::TestCase

  describe "Subjects Controller Tests" do
    let(:admin) { users(:admin_user) }
    let(:parent) { users(:jj_parent) }
    let(:maths) { subjects(:maths) }
    let(:english) { subjects(:english) }

    describe "actions by a non logged in user" do

      it "raises an unauthorised error when trying to add a subject" do
        post :create, subscription: { subject_id: maths.id }
        assert_response 401
        @controller.instance_variable_get('@subject').must_equal nil
      end

    end


  end

end