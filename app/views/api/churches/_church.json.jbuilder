church ||= nil

if church
  json.id church.id
  json.name church.name
end
