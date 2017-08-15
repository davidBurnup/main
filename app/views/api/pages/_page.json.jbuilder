page ||= nil
if page
  json.id page.id
  json.name page.name
  json.slogan page.slogan
  json.address page.address
  json.avatar do
    json.medium page.avatar.url(page.svg? ? :original : :medium)
    json.thumb page.avatar.url(page.svg? ? :original : :thumb)
    json.tiny page.avatar.url(page.svg? ? :original : :tiny)
  end
end
