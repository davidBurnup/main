if Rails.env.production?
  ActionMailer::Base.default_url_options[:host] = "burnup.ac-ac.fr"
  ActionMailer::Base.smtp_settings = {
    :address   => "smtp.mailgun.org",
    :port      => 587, # ports 587 and 2525 are also supported with STARTTLS
    :enable_starttls_auto => true, # detects and uses STARTTLS
    :user_name => "postmaster@ac-ac.fr",
    :password  => Rails.application.secrets.mailgun_api_key, # SMTP password is any valid API key
    :authentication => 'login', # Mandrill supports 'plain' or 'login'
    :domain => 'ac-ac.fr', # your domain to identify your server when connecting
  }
end
