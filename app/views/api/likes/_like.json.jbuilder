likable ||= nil

if likable

  likers = User.where(id: (likable.likers(User).collect(&:id) - [current_user.id]))

  json.likers likers do |user|
    json.id user.id
    json.name user.short_name
  end

  if current_user
    json.liked current_user.likes?(likable)
  end
end
