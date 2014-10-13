if Rails.env.production?
  ActionMailer::Base.default_url_options[:host] = "burnup.ac-ac.fr"
  ActionMailer::Base.smtp_settings = {
    :address   => "smtp.mandrillapp.com",
    :port      => 587, # ports 587 and 2525 are also supported with STARTTLS
    :enable_starttls_auto => true, # detects and uses STARTTLS
    :user_name => "dfabreguette@gmail.com",
    :password  => "uhpV0YrqtJ9Lz7oPShYj8A", # SMTP password is any valid API key
    :authentication => 'login', # Mandrill supports 'plain' or 'login'
    :domain => 'burnup.ac-ac.fr', # your domain to identify your server when connecting
  }
end