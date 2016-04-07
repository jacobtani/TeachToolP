require 'test_helper'

class PackRecordTest < ActiveSupport::TestCase

  describe "PackRecord Model Tests" do
    let(:english) { subjects(:english) }
    let (:pack) { packs(:five_junior_e) }
    let (:pack_maths_1) { packs(:five_junior_m) }
    let (:pack_english_2) { packs(:five_advanced_e) }
    let (:pack_maths_2) { packs(:five_advanced_m) }
    let (:student) { users(:iain_student) }

    describe "invalid pack records" do

      it "doesn't allow invalid pack records to be created - missing amount" do
        @pack_record = PackRecord.create(start_date: Date.today, due_date: Date.today + 1.week, user_id: student.id, status: 'DISPATCHED')
        @pack_record.valid?.must_equal false
        assert_equal [:pack_id], @pack_record.errors.keys
      end

      it "doesn't allow invalid fees to be created - end date before start date" do
        @pack_record = PackRecord.create(start_date: Date.today, due_date: Date.today - 1.week, user_id: student.id, status: 'DISPATCHED', pack_id: pack.id)
        @pack_record.valid?.must_equal false
        assert_equal [:due_date], @pack_record.errors.keys
      end

    end

    describe "valid pack records" do 

      it "creates valid fees to be created" do
        @pack_record = PackRecord.create(start_date: Date.today, due_date: Date.today + 1.week, user_id: student.id, status: 'DISPATCHED', pack_id: pack.id)
        @pack_record.valid?.must_equal true
      end

    end

    describe "computes posting number" do

      it "creates the right posting number" do 
        @pack_record = PackRecord.create(start_date: Date.today + 1.week, due_date: Date.today + 2.week, user_id: student.id, status: 'DISPATCHED', pack_id: pack.id)
        posting_number = PackRecord.compute_posting_number(student)
        posting_number.must_equal 1
      end

    end

    describe "computes score and reward correctly" do 

      it "computes the middle category rewards correctly " do
        @pack_record = PackRecord.create(start_date: Date.today + 1.week, due_date: Date.today + 2.week, user_id: student.id, status: 'DISPATCHED', pack_id: pack.id)
        @pack_record.update(status: 'COMPLETED', accuracy: 100, quality: 80, completion: 90, presentation: 50, consistency: 30)
        score = PackRecord.calculate_score(@pack_record)
        score.must_equal 82.5
        PackRecord.calculate_reward(score).must_equal 1.00
      end

      it "computes the high performance rewards correctly " do
        @pack_record = PackRecord.create(start_date: Date.today + 1.week, due_date: Date.today + 2.week, user_id: student.id, status: 'DISPATCHED', pack_id: pack_maths_1.id)
        @pack_record.update(status: 'COMPLETED', accuracy: 100, quality: 100, completion: 100, presentation: 100, consistency: 100)
        score = PackRecord.calculate_score(@pack_record)
        score.must_equal 100
        PackRecord.calculate_reward(score).must_equal 1.50
      end

      it "computes the low category rewards correctly " do
        @pack_record = PackRecord.create(start_date: Date.today + 1.week, due_date: Date.today + 2.week, user_id: student.id, status: 'DISPATCHED', pack_id: pack_maths_2.id)
        @pack_record.update(status: 'COMPLETED', accuracy: 80, quality: 70, completion: 80, presentation: 70, consistency: 70)
        score = PackRecord.calculate_score(@pack_record)
        score.must_equal 76.5
        PackRecord.calculate_reward(score).must_equal 0.50
      end

      it "computes the no reward situation correctly " do
        @pack_record = PackRecord.create(start_date: Date.today + 1.week, due_date: Date.today + 2.week, user_id: student.id, status: 'DISPATCHED', pack_id: pack_maths_2.id)
        @pack_record.update(status: 'COMPLETED', accuracy: 10, quality: 10, completion: 10, presentation: 10, consistency: 10)
        score = PackRecord.calculate_score(@pack_record)
        score.must_equal 10
        PackRecord.calculate_reward(score).must_equal 0
      end

    end

  end

end