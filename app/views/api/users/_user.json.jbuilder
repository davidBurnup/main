user ||= nil

if user
  json.id user.id
  json.church_id user.church_id
  json.avatar do
    json.original user.avatar.url(:original)
    json.tiny user.avatar.url(:tiny)
    json.medium user.avatar.url(:medium)
  end
  if !user.avatar.present?
    json.no_avatar true
  end
end
