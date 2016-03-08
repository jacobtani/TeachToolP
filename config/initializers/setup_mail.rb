ActionMailer::Base.smtp_settings = {
  :address              => "smtp.gmail.com",
  :port                 => 587,
  :user_name            => "tjterminator.dev@gmail.com",
  :password             => "Anita551",
  :authentication       => "plain",
  :enable_starttls_auto => true
}