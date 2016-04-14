require 'test_helper'

class EnrolmentTest < ActiveSupport::TestCase

  describe "Enrolment Model Tests" do
    let(:maths) { subjects(:maths) }
    let(:english) { subjects(:english) }
    let(:english_pack) { packs(:five_junior_e) }
    let (:pack_maths_1) { packs(:five_junior_m) }
    let (:pack_maths_2) { packs(:five_advanced_m) }
    let (:student) { users(:iain_student) }
    let (:tj_student) { users(:tj_student) }
    let (:maths_offer) { offers(:offer_maths) }
    let (:english_offer) { offers(:offer_english) }
    let (:english_offer_percentage) { offers(:offer_english_percentage) }
    let (:enrolment_discount_offer) { offers(:offer_enrolment_discount) }
    let (:enrolment_discount_amount_offer) { offers(:offer_enrolment_discount_amount) }

    describe "invalid enrolments" do

      it "doesn't allow invalid enrolments to be created - missing user id " do
        @enrolment = Enrolment.create(user_id: tj_student.id, monthly_fee: 150, grade: 3, subject_id: maths.id, ability_level: 8)
        @enrolment.valid?.must_equal false
        assert_equal [:date], @enrolment.errors.keys
      end

   end

    describe "valid enrolments" do

      it "creates valid enrolments to be created" do
        @enrolment = Enrolment.create(date: Date.today, user_id: student.id, monthly_fee: 160, grade: 3, subject_id: english.id, ability_level: 8)
        @enrolment.valid?.must_equal true
      end

      it "ensures there is one subject and user id enrolment " do
        @enrolment = Enrolment.create(date: Date.today, user_id: student.id, monthly_fee: 300, grade: 3, subject_id: maths.id, ability_level: 8)
        @enrolment.valid?.must_equal false
        assert_equal [:user_id], @enrolment.errors.keys
        assert_equal ["can only enrol once per subject"], @enrolment.errors.messages[:user_id]
      end

    end

    describe "applies monthly_fees correctly when there are no offers selected" do 

      it "sets right monthly_fees when no offers" do 
        my_enrolment = Enrolment.create(date: Date.today, user_id: tj_student.id, grade: 3, subject_id: english.id, ability_level: 8)
        Enrolment.validate_offer(tj_student, my_enrolment)
        my_enrolment.monthly_fee.must_equal 160
        tj_student.enrolment_fee.must_equal 100
      end

      it "applies a monthly discount correctly to monthly_fees for an enrolment when no enrolment fee" do 
        enrolment = Enrolment.create(date: Date.today, user_id: student.id, grade: 3, subject_id: english.id, ability_level: 8, offer_id: english_offer.id)
        Enrolment.validate_offer(student, enrolment)
        enrolment.monthly_fee.must_equal 120
        tj_student.enrolment_fee.must_equal 0
      end

      it "applies a monthly discount correctly to monthly_fees for an enrolment when no enrolment fee" do 
        enrolment = Enrolment.create(date: Date.today, user_id: student.id, grade: 3, subject_id: english.id, ability_level: 8, offer_id: english_offer.id)
        Enrolment.validate_offer(student, enrolment)
        enrolment.monthly_fee.must_equal 120
        student.enrolment_fee.must_equal 0
      end

      it "applies a monthly discount percentage correctly to monthly_fees for an enrolment when no enrolment fee" do 
        enrolment = Enrolment.create(date: Date.today, user_id: student.id, grade: 3, subject_id: english.id, ability_level: 8, offer_id: english_offer_percentage.id)
        Enrolment.validate_offer(student, enrolment)
        enrolment.monthly_fee.must_equal 80
        student.enrolment_fee.must_equal 0
      end

      it "calculates total monthly_fees when no enrolments present for student" do 
        enrolment = Enrolment.create(date: Date.today, user_id: tj_student.id, grade: 6, subject_id: maths.id, ability_level: 2, offer_id: maths_offer.id)
        Enrolment.validate_offer(tj_student, enrolment)
        enrolment.monthly_fee.must_equal 120
        tj_student.enrolment_fee.must_equal 100
      end

      it "calculates enrolment discount percentage correctly" do 
        enrolment = Enrolment.create(date: Date.today, user_id: tj_student.id, grade: 6, subject_id: maths.id, ability_level: 2, offer_id: enrolment_discount_offer.id)
        Enrolment.validate_offer(tj_student, enrolment)
        enrolment.monthly_fee.must_equal 160
        tj_student.enrolment_fee.must_equal 80
      end

      it "calculates enrolment discount amount correctly" do 
        enrolment = Enrolment.create(date: Date.today, user_id: tj_student.id, grade: 6, subject_id: maths.id, ability_level: 2, offer_id: enrolment_discount_amount_offer.id)
        Enrolment.validate_offer(tj_student, enrolment)
        enrolment.monthly_fee.must_equal 160
      end

    end

  end

end