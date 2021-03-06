if Rails.env.production?
  ActionMailer::Base.default_url_options[:host] = "burnup.fr"
  # ActionMailer::Base.smtp_settings = {
  #   :address   => "smtp.mailgun.org",
  #   :port      => 587, # ports 587 and 2525 are also supported with STARTTLS
  #   :enable_starttls_auto => true, # detects and uses STARTTLS
  #   :user_name => "postmaster@sandbox57f9a0eb31734214b5839beda27c123a.mailgun.org",
  #   :password  => Rails.application.secrets.mailgun_api_key, # SMTP password is any valid API key
  #   :authentication => 'login', # Mandrill supports 'plain' or 'login'
  #   :domain => 'sandbox57f9a0eb31734214b5839beda27c123a.mailgun.org', # your domain to identify your server when connecting
  # }
  ActionMailer::Base.smtp_settings = {
    :address   => "ssl0.ovh.net",
    :port      => 587, # ports 587 and 2525 are also supported with STARTTLS
    :enable_starttls_auto => true, # detects and uses STARTTLS
    :user_name => "pas-de-reponse@ac-ac.fr",
    :password  => Rails.application.secrets.ovh_password, # SMTP password is any valid API key
    :authentication => 'login', # Mandrill supports 'plain' or 'login'
    :domain => 'sandbox57f9a0eb31734214b5839beda27c123a.mailgun.org', # your domain to identify your server when connecting
  }
  # ActionMailer::Base.smtp_settings = {
  #   :user_name => Rails.application.secrets.MAILTRAP_USER,
  #   :password => Rails.application.secrets.MAILTRAP_PWD,
  #   :address => 'smtp.mailgun.org',
  #   :domain => 'smtp.mailgun.org',
  #   :port => '2525',
  #   :authentication => :cram_md5
  # }
end
