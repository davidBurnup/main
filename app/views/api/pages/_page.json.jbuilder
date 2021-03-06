page ||= nil
if page
  json.id page.id
  json.name page.name
  json.slogan page.slogan
  json.description page.description
  json.youtube_video_id page.youtube_video_id
  json.address page.address
  json.is_editable page.is_admin?(current_user)
  json.is_followed page.is_followed_by?(current_user)
  json.has_any_songs page.has_any_songs?

  if page.youtube_url.present?
    json.youtube_url page.youtube_url
  end

  if page.facebook_url.present?
    json.facebook_url page.facebook_url
  end

  if page.twitter_url.present?
    json.twitter_url page.twitter_url
  end

  if page.patreon_url.present?
    json.patreon_url page.patreon_url
  end

  json.avatar do
    json.medium page.avatar.url(page.svg? ? :original : :medium)
    json.thumb page.avatar.url(page.svg? ? :original : :thumb)
    json.tiny page.avatar.url(page.svg? ? :original : :tiny)
  end

  json.logo do
    json.banner page.logo.url(page.svg? ? :original : :banner)
  end

  json.background_image do
    json.cover page.avatar.url(page.svg? ? :original : :cover)
  end
  json.urls do
    json.songs page_songs_path(page)
  end
end
