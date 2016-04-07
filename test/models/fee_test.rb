require 'test_helper'

class FeeTest < ActiveSupport::TestCase

  describe "Fee Model Tests" do
    let(:english) { subjects(:english) }

    describe "invalid fees" do

      it "doesn't allow invalid fees to be created - missing amount" do
        @fee = Fee.create(fee_name: 'New Science Fee', start_date: Date.today, end_date: Date.today + 1.week)
        @fee.valid?.must_equal false
        assert_equal [:amount], @fee.errors.keys
      end

      it "doesn't allow invalid fees to be created - end date before start date" do
        @fee = Fee.create(fee_name: 'New Science Fee', start_date: Date.today + 1.year, end_date: Date.today, amount: 250)
        @fee.valid?.must_equal false
        assert_equal [:end_date], @fee.errors.keys
      end

    end

    describe "valid fees" do 

      it "creates valid fees to be created" do
        @fee = Fee.create(fee_name: 'New Science Fee', start_date: Date.today, end_date: Date.today + 1.week, amount: 250)
        @fee.valid?.must_equal true
      end

    end

  end

end