require 'test_helper'

class EnclosureTest < ActiveSupport::TestCase

  describe "Enclosure Model Tests" do
    let(:maths) { subjects(:maths) }
    let(:maths_pack) { packs(:five_advanced_m) }

    describe "invalid enclosures" do

      it "doesn't allow invalid enclosures to be created - missing status" do
        @enclosure = Enclosure.create(name: 'Learn Linear Graphs', barcode: 1214345, enclosure_type:'FREE', due_date: Date.today + 2.weeks, pack_id: maths_pack.id)
        @enclosure.valid?.must_equal false
        assert_equal [:status], @enclosure.errors.keys
      end

    end

    describe "valid enclosures" do 

      it "creates valid enclosures to be created" do
        @enclosure = Enclosure.create(name: 'Learn Linear Graphs', barcode: 1214345, enclosure_type:'FREE', due_date: Date.today + 2.weeks, pack_id: maths_pack.id, status: 'AVAILABLE')
        @enclosure.valid?.must_equal true
      end

    end

  end

end