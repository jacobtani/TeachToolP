require "test_helper"

class AdminMailerTest < ActionMailer::TestCase
    let(:student) { users(:iain_student) }

  def test_reminder_nullify_rewards
    email = AdminMailer.reminder_nullify_rewards.deliver_now
    assert_not ActionMailer::Base.deliveries.empty? 
    assert_equal ['tanzjacob@gmail.com'], email.from
    assert_equal ['tjterminator.dev@gmail.com'], email.to
    assert_equal 'NULLIFY REWARDS TIME', email.subject
  end

  def test_redeem_reward
    email = AdminMailer.redeem_reward(student, 20).deliver_now
    assert_not ActionMailer::Base.deliveries.empty? 
    assert_equal ['jj@gmail.com'], email.from
    assert_equal ['tjterminator.dev@gmail.com'], email.to
    assert_equal 'REWARD REDEMPTION', email.subject
  end

  def test_registration_confirmation_to_admin
    email = AdminMailer.registration_confirmation_to_admin(student).deliver_now
    assert_not ActionMailer::Base.deliveries.empty? 
    assert_equal ['jj@gmail.com'], email.from
    assert_equal ['tjterminator.dev@gmail.com'], email.to
    assert_equal 'ADDING NEW USER', email.subject
  end

end
