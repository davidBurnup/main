module MailerHelper
  def email_image_tag(image_name)
    asset_url("email/#{image_name}")
  end
end
