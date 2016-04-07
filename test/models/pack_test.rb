require 'test_helper'

class PackTest < ActiveSupport::TestCase

  describe "Pack Model Tests" do
    let(:maths) { subjects(:maths) }
    let(:english_pack) { packs(:five_junior_e) }

    describe "invalid packs" do

      it "doesn't allow invalid packs to be created - missing subject_id" do
        @pack = Pack.create(name: '7++ Maths', description: 'An advanced Maths pack for seventh graders', pack_type: 'NORMAL', priority: 1, number_unassigned: 20)
        @pack.valid?.must_equal false
        assert_equal [:subject_id], @pack.errors.keys
      end

    end

    describe "valid packs" do 

      it "creates valid packs to be created" do
        @pack = Pack.create(name: '7++ Maths', description: 'An advanced Maths pack for seventh graders', subject_id: maths.id, pack_type: 'NORMAL', priority: 1, number_unassigned: 20)
        @pack.valid?.must_equal true
      end

    end

    describe "correct update of packs when they are assigned" do

      it "updates stock when packs assigned to students" do
        english_pack.number_unassigned.must_equal 20
        english_pack.number_assigned.must_equal 0
        Pack.update_stock(english_pack)
        english_pack.reload.number_unassigned.must_equal 19
        english_pack.number_assigned.must_equal 1
      end

	end

  end

end