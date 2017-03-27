if activity and t = activity.trackable and t.feedable_option(:title).present? and t.feedable_option(:content).present?
  json.id activity.id
  if activity.owner
    json.owner do
      json.partial! "/api/users/user", user: activity.owner
    end
  end

  json.title t.feedable_option(:title)
  json.trackable_type t.class.to_s
  json.trackable_id t.id
  json.content t.feedable_option(:content)
  json.image t.feedable_option(:image)
  json.image_link t.feedable_option(:image_link)
  json.activity_link t.feedable_option(:activity_link)

  json.partial! "/api/likes/like", likable: activity

  json.created_at l(activity.created_at)
  json.policy do
    json.destroy policy(activity).destroy?
  end

  json.comments activity.comments do |comment|
    json.partial! "/api/activities/comments/comment", comment: comment
  end

  json.url api_activity_url(activity, format: :json)
end
