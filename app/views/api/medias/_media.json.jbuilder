media ||= nil

if media
  json.id media.id

  if media.attachment.present?
    json.attachment do
      json.url media.attachment.url
      json.content_type media.attachment_type
      json.thumb media.attachment_thumb
      json.file_name media.attachment_file_name
    end
  end

  if media.image.present?
    json.image do
      json.original media.image.url( :original)
      json.large media.image.url( :large)
      json.medium_uncropped media.image.url( :medium_uncropped)
      json.medium media.image.url( :medium)
      json.thumb media.image.url( :thumb)
      json.mini media.image.url( :mini)
      json.micro media.image.url( :micro)
    end

  # elsif media.attachment.present?
  #   json.file do
  #     json.url media.attachment.url
  #     json.thumb media.attachment_thumb
  #     json.name media.attachment_file_name
  #   end
  end

end
