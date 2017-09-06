page ||= nil
if page
  json.id page.id
  json.name page.name
  json.slogan page.slogan
  json.description page.description
  json.youtube_video_id page.youtube_video_id
  json.address page.address
  json.is_edidable current_user and page.is_admin?(current_user)
  json.avatar do
    json.medium page.avatar.url(page.svg? ? :original : :medium)
    json.thumb page.avatar.url(page.svg? ? :original : :thumb)
    json.tiny page.avatar.url(page.svg? ? :original : :tiny)
  end
  json.background_image do
    json.cover page.avatar.url(page.svg? ? :original : :cover)
  end
end
