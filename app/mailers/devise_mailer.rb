class DeviseMailer < Devise::Mailer
  helper MailerHelper
  layout 'mailer'
  default from: 'contact@burnup.fr'

  def confirmation_instructions(user, token, opts={})
    @token = token
    @user = user
    subject = "Finaliser votre compte Burnup !"
    mail(to: user.email, subject: subject)
  end

  def reset_password_instructions(user, token, opts={})
    @token = token
    @user = user
    subject = "Changer votre mot de passe Burnup !"

    mail(to: user.email, subject: subject)
  end


end
