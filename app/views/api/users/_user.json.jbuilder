user ||= nil

if user
  json.id user.id
  json.church_id user.church_id
  if user.avatar.present?
    json.avatar do
      json.original user.avatar.url(:original)
      json.tiny user.avatar.url(:tiny)
    end
  end
end
