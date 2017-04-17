user ||= nil

if user
  json.id user.id
  json.church_id user.church_id
  json.full_name user.full_name
  json.avatar do
    json.original user.avatar.url(:original)
    json.tiny user.avatar.url(:tiny)
  end
  if !user.avatar.present?
    json.no_avatar true
  end
end
