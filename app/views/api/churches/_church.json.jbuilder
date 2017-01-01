church ||= nil

if church
  json.id church.id
  json.name church.name
  json.address church.address
  json.logo do
    json.medium church.logo.url(:medium)
    json.thumb church.logo.url(:thumb)
  end
end
