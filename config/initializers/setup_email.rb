#
#
#if Rails.env.production?
#  ActionMailer::Base.default_url_options[:host] = "ac-ac.fr"
#  ActionMailer::Base.smtp_settings = {
#      :address              => "ac-ac.fr",
#      :port                 => 25,
#      :user_name            => "contact",
#      :password             => ENV['EMAIL_PWD'],
#      :authentication       => "plain",
#      :enable_starttls_auto => true
#  }
#else
#  ActionMailer::Base.default_url_options[:host] = "localhost:3000"
#  ActionMailer::Base.smtp_settings = {
#      :address              => "smtp.gmail.com",
#      :port                 => 587,
#      :user_name            => "acac.newsletter",
#      :password             => "qsdfmimieqsdf",
#      :authentication       => "plain",
#      :enable_starttls_auto => true
#  }
#end
