require 'test_helper'

class SubjectTest < ActiveSupport::TestCase

  describe "Subject Model Tests" do
    let(:english) { subjects(:english) }

    describe "invalid subjects" do

      it "doesn't allow invalid subjects to be created - missing fee_id" do
        @subject = Subject.create(subject_name: 'French', lowest_grade_taught: 5, highest_grade_taught: 12)
        @subject.valid?.must_equal false
        assert_equal [:fee_id], @subject.errors.keys
      end

      it "doesn't allow invalid subjects to be created - same subject twice" do
        @fee = Fee.create(fee_name: 'French Fee', amount: 100, start_date: Date.today, end_date: Date.today + 1.year, fee_type: 'MONTHLY')
        @subject = Subject.create(subject_name: 'English', lowest_grade_taught: 5, highest_grade_taught: 12, fee_id: @fee.id)
        @subject.valid?.must_equal false
        assert_equal [:subject_name], @subject.errors.keys
      end

    end

    describe "valid subjects" do 

      it "creates valid subjects to be created" do
        @fee = Fee.create(fee_name: 'French Fee', amount: 100, start_date: Date.today, end_date: Date.today + 1.year, fee_type: 'MONTHLY')
        @subject = Subject.create(subject_name: 'French', lowest_grade_taught: 5, highest_grade_taught: 12, fee_id: @fee.id)
        @subject.valid?.must_equal true
      end

    end

  end

end