page ||= nil

if page
  json.id page.id
  json.name page.name
  json.slogan page.slogan
  json.address page.address
  json.logo do
    json.medium page.logo.url(page.svg? ? :original : :medium)
    json.thumb page.logo.url(page.svg? ? :original : :thumb)
  end
end
