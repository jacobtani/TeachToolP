require 'test_helper'

class UserTest < ActiveSupport::TestCase

  describe "User Model Tests" do
    let(:maths) { subjects(:maths) }
    let(:english_pack) { packs(:five_junior_e) }
    let (:pack_maths_1) { packs(:five_junior_m) }
    let (:pack_maths_2) { packs(:five_advanced_m) }
    let (:student) { users(:iain_student) }
    let (:admin) { users(:admin_user) }
    let (:employee) { users(:employee_user) }
    let (:parent) { users(:jj_parent) }

    describe "invalid users" do

      it "doesn't allow invalid users to be created - missing surname, email, password " do
        @user = User.create(first_name: 'Test', role: 'student', contact_email: 'jj@gmail.com', postal_address: '5 The Rock', city: 'New York', state: 'NY', zip_code: 5011)
        @user.valid?.must_equal false
        assert_equal [:email, :password, :surname], @user.errors.keys
      end

      it "doesn't allow invalid users to be created - date of birth is after today's date " do
        @user = User.create(first_name: 'The', surname: 'User', role: 'student', contact_email: 'jj@gmail.com', postal_address: '5 The Rock', city: 'New York', state: 'NY', zip_code: 5011, date_of_birth: '11/09/2016', email: 'myuser@gmail.com', password: 'hahahaha' )
        @user.valid?.must_equal false
        assert_equal [:date_of_birth], @user.errors.keys
      end

    end

    describe "valid users" do 

      it "creates valid users to be created" do
        @user = User.create(first_name: 'The', surname: 'User', role: 'student', contact_email: 'jj@gmail.com', postal_address: '5 The Rock', city: 'New York', state: 'NY', zip_code: 5011, date_of_birth: '11/09/1992', email: 'myuser@gmail.com', password: 'hahahaha' )
        @user.valid?.must_equal true
      end

    end

    describe "identifies user name and roles correctly" do

      it "gets the right full name for a user" do
        student.full_name.must_equal "Iain Awesome"
        admin.full_name.must_equal "Admin User"
        employee.full_name.must_equal "Employee User"
        parent.full_name.must_equal "JJ Parent"
      end

      it "identifies an admin correctly" do
        student.admin?.must_equal false
        parent.admin?.must_equal false
        employee.admin?.must_equal false
        admin.admin?.must_equal true
      end

      it "identifies a student correctly" do
        student.student?.must_equal true
        parent.student?.must_equal false
        employee.student?.must_equal false
        admin.student?.must_equal false
      end

      it "identifies a parent correctly" do
        student.parent?.must_equal false
        parent.parent?.must_equal true
        employee.parent?.must_equal false
        admin.parent?.must_equal false
      end

      it "identifies a privileged user" do
        student.privileged?.must_equal false
        parent.privileged?.must_equal false
        employee.privileged?.must_equal true
        admin.privileged?.must_equal true
      end

    end

    describe "it calculates sums correctly" do 

      it "calculates total fees" do 
        fees = student.calculate_total_fees(student)
        fees.must_equal 260
      end

      it "determines if student needs suspension with 2 dispatched PRs" do 
        @pack_record = PackRecord.create(start_date: Date.today + 1.week, due_date: Date.today + 2.week, user_id: student.id, status: 'DISPATCHED', pack_id: pack_maths_1.id)
        @pack_record = PackRecord.create(start_date: Date.today + 1.week, due_date: Date.today + 2.week, user_id: student.id, status: 'DISPATCHED', pack_id: pack_maths_2.id)
        student.needs_suspension?.must_equal true
      end

      it "determines no suspension for student" do 
        @pack_record = PackRecord.create(start_date: Date.today + 1.week, due_date: Date.today + 2.week, user_id: student.id, status: 'DISPATCHED', pack_id: pack_maths_2.id)
        student.needs_suspension?.must_equal false
      end

    end

  end

end