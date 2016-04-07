require 'test_helper'

class OfferTest < ActiveSupport::TestCase

  describe "Offer Model Tests" do
    let(:english) { subjects(:english) }

    describe "invalid offers" do

      it "doesn't allow invalid offers to be created - missing end date" do
        @offer = Offer.create(subject_id: english.id, start_date: Date.today + 1.week, offer_name: 'Short Time Offer', offer_description: 'This is great get it while it lasts')
        @offer.valid?.must_equal false
        assert_equal [:end_date], @offer.errors.keys
      end

      it "doesn't allow invalid offers to be created - end date before start date" do
        @offer = Offer.create(subject_id: english.id, start_date: Date.today, end_date: Date.today - 1.year, offer_name: 'Short Time Offer', offer_description: 'This is great get it while it lasts')
        @offer.valid?.must_equal false
        assert_equal [:end_date], @offer.errors.keys
      end

    end

    describe "valid offers" do 

      it "creates valid offers to be created" do
        @offer = Offer.create(subject_id: english.id, start_date: Date.today, end_date: Date.today + 1.year, offer_name: 'Best English Offer', offer_description: 'This is great get it while it lasts')
        @offer.valid?.must_equal true
      end

    end

  end

end