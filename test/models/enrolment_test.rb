require 'test_helper'

class EnrolmentTest < ActiveSupport::TestCase

  describe "Enrolment Model Tests" do
    let(:maths) { subjects(:maths) }
    let(:english) { subjects(:english) }
    let(:english_pack) { packs(:five_junior_e) }
    let (:pack_maths_1) { packs(:five_junior_m) }
    let (:pack_maths_2) { packs(:five_advanced_m) }
    let (:student) { users(:iain_student) }
    let (:admin) { users(:admin_user) }
    let (:employee) { users(:employee_user) }
    let (:parent) { users(:jj_parent) }

    describe "invalid enrolments" do

      it "doesn't allow invalid enrolments to be created - missing user id " do
        @enrolment = Enrolment.create(date: Date.today, fees: 300, grade: 3, subject_id: maths.id, ability_level: 8)
        @enrolment.valid?.must_equal false
        assert_equal [:user_id], @enrolment.errors.keys
      end

   end

    describe "valid enrolments" do

      it "creates valid enrolments to be created" do
        @enrolment = Enrolment.create(date: Date.today, user_id: student.id, fees: 300, grade: 3, subject_id: english.id, ability_level: 8)
        @enrolment.valid?.must_equal true
      end

      it "ensures there is one subject and user id enrolment " do
        @enrolment = Enrolment.create(date: Date.today, user_id: student.id, fees: 300, grade: 3, subject_id: maths.id, ability_level: 8)
        @enrolment.valid?.must_equal false
        assert_equal [:user_id], @enrolment.errors.keys
        assert_equal ["can only enrol once per subject"], @enrolment.errors.messages[:user_id]
      end

    end

  end

end