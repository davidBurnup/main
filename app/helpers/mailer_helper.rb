module MailerHelper
  def email_image_tag(image_name)
    attachments[image_name].url
  end
end
