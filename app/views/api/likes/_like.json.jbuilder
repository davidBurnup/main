likable ||= nil

if likable
  user_ids = likable.likers(User).collect(&:id)
  if current_user
    user_ids << current_user.id
  end
  likers = User.where(id: user_ids)

  json.likers likers do |user|
    json.id user.id
    json.name user.short_name
    json.avatar do
      json.original user.avatar.url(:original)
      json.tiny user.avatar.url(:tiny)
    end
    json.paths do
      json.show user_path(user)
    end
  end

  if current_user
    json.liked current_user.likes?(likable)
  end
end
