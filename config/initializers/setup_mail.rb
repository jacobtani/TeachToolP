ActionMailer::Base.smtp_settings = {
  :address              => "smtp.gmail.com",
  :port                 => 587,
  :user_name            => "tjterminator.dev@gmail.com",
  :password             => "tania551",
  :authentication       => "plain",
  :enable_starttls_auto => true
}