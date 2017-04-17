post ||= nil
if post and post.activity
  json.id post.id
  json.activity_id post.activity.id
end
