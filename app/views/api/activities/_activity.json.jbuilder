if activity
  json.id activity.id
  if activity.owner
    json.owner do
      json.partial! "/api/users/user", user: activity.owner
    end
  end
end
