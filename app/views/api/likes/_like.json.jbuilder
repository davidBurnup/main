likable ||= nil

if likable

  likers = User.where(id: (likable.likers(User).collect(&:id) - (current_user ? [current_user.id] : []) ))

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
