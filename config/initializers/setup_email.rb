if Rails.env.production?
  ActionMailer::Base.default_url_options[:host] = "ac-ac.fr"
  ActionMailer::Base.smtp_settings = {
      :address              => "ac-ac.fr",
      :port                 => 25,
      :user_name            => "contact",
      :password             => ENV['EMAIL_PWD'],
      :authentication       => "plain",
      :enable_starttls_auto => true
  }
end