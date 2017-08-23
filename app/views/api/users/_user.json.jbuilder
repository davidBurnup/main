user ||= nil

if user
  json.id user.id
  json.page_id user.page_id
  json.full_name user.full_name
  json.avatar do
    json.original user.avatar.url(:original)
    json.tiny user.avatar.url(:tiny)
    json.medium user.avatar.url(:medium)
  end
  if !user.avatar.present?
    json.no_avatar true
  end
end
