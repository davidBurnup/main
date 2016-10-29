if Rails.env.production?
  ActionMailer::Base.default_url_options[:host] = "burnup.ac-ac.fr"
  ActionMailer::Base.smtp_settings = {
    :address   => "smtp.mailgun.org",
    :port      => 587, # ports 587 and 2525 are also supported with STARTTLS
    :enable_starttls_auto => true, # detects and uses STARTTLS
    :user_name => "postmaster@sandbox57f9a0eb31734214b5839beda27c123a.mailgun.org",
    :password  => Rails.application.secrets.mailgun_api_key, # SMTP password is any valid API key
    :authentication => 'login', # Mandrill supports 'plain' or 'login'
    :domain => 'sandbox57f9a0eb31734214b5839beda27c123a.mailgun.org', # your domain to identify your server when connecting
  }
end
