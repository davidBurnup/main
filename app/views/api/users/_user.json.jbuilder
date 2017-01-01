user ||= nil

if user
  json.id user.id
  json.church_id user.church_id
end
