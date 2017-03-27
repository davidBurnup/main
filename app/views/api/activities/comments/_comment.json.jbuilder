if comment and comment.commentable
  json.id comment.id
  json.activityId comment.commentable.id
  json.comment comment.comment
  json.created_at l(comment.created_at)
  if comment.creator
    json.creator do
      json.id comment.creator.id
      json.short_name comment.creator.short_name
      json.avatar do
        json.original comment.creator.avatar.url(:original)
        json.tiny comment.creator.avatar.url(:tiny)
      end
    end
  end
end
