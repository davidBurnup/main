if activity and t = activity.trackable #and t.feedable_option(:title).present? #and t.feedable_option(:content).present?
  json.id activity.id
  if activity.owner
    json.owner do
      # json.partial! "/api/users/user", user: activity.owner
      json.partial! "/api/#{activity.owner.class.to_s.underscore.pluralize}/#{activity.owner.class.to_s.underscore}", "#{activity.owner.class.to_s.underscore.to_sym}": activity.owner
      json.url url_for(activity.owner)
    end
  end

  json.title t.feedable_option(:title)
  json.trackable_type t.class.to_s
  json.trackable_id t.id
  json.content t.feedable_option(:content)
  json.image t.feedable_option(:image)
  json.image_link t.feedable_option(:image_link)

  if t.feedable_option(:activity_link).present?
    json.activity_link t.feedable_option(:activity_link)
  else
    json.activity_link activity_path(activity)
  end
  
  json.partial! "/api/likes/like", likable: activity

  json.created_at l(activity.created_at)
  json.updated_at l(activity.updated_at)
  json.policy do
    json.destroy policy(activity).destroy?
  end

  json.comments activity.comments do |comment|
    json.partial! "/api/activities/comments/comment", comment: comment
  end

  if t.respond_to? :medias
    json.medias t.medias do |media|
      json.partial! "/api/medias/media", media: media
    end
  end

  json.url api_activity_url(activity, format: :json)
end
