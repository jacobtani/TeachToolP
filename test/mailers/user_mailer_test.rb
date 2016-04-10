require "test_helper"

class UserMailerTest < ActionMailer::TestCase

    let(:admin) { users(:admin_user) }
    let(:employee) { users(:employee_user) }
    let(:parent) { users(:jj_parent) }
    let(:student) { users(:iain_student) }
    let(:tj_student) { users(:tj_student) }
    let(:english) { subjects(:english) }
    let(:english_offer) { offers(:offer_english) }
    let(:maths_offer) { offers(:offer_maths) }
    let(:english_pack) { packs(:five_junior_e) }
    let(:pack_record_iain) { pack_records(:iain_pack_record_one) }

  def test_registration_user
    email = UserMailer.registration_confirmation_to_user(student).deliver_now
    assert_not ActionMailer::Base.deliveries.empty? 
    assert_equal ['tjterminator.dev@gmail.com'], email.from
    assert_equal ['jj@gmail.com'], email.to
    assert_equal 'Registration Complete for iwavez', email.subject
  end

 def test_registration_parent
    email = UserMailer.registration_confirmation_to_user(parent).deliver_now
    assert_not ActionMailer::Base.deliveries.empty? 
    assert_equal ['tjterminator.dev@gmail.com'], email.from
    assert_equal ['jj@gmail.com'], email.to
    assert_equal 'Registration Complete for iwavez', email.subject
  end

  def test_suspension_email
    email = UserMailer.suspension_email(student)
    assert ActionMailer::Base.deliveries.empty? 
    assert_equal ['tjterminator.dev@gmail.com'], email.from
    assert_equal ['jj@gmail.com'], email.to
    assert_equal 'Suspension of iwavez Account', email.subject
  end    

  def test_new_work_email
    email = UserMailer.new_work_email(student, Pack.last)
    assert_equal ['tjterminator.dev@gmail.com'], email.from
    assert_equal ['jj@gmail.com'], email.to
    assert_equal 'New work added to iwavez Account', email.subject
  end    

  def test_reward_expiry_reminder
    email = UserMailer.reward_expiry_reminder(student)
    assert ActionMailer::Base.deliveries.empty? 
    assert_equal ['tjterminator.dev@gmail.com'], email.from
    assert_equal ['jj@gmail.com'], email.to
    assert_equal 'Rewards expiring in 1 week', email.subject
  end    

  def test_work_missing
    email = UserMailer.work_missing(student, pack_record_iain)
    assert_equal ['tjterminator.dev@gmail.com'], email.from
    assert_equal ['jj@gmail.com'], email.to
    assert_equal 'Work missing for iwavez', email.subject
  end    

  def test_send_enrolment_deletion
    email = UserMailer.send_enrolment_deletion(student)
    assert_equal ['tjterminator.dev@gmail.com'], email.from
    assert_equal ['jj@gmail.com'], email.to
    assert_equal 'Confirmation of Enrolment Deletion for iwavez', email.subject
  end    

end
