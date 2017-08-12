post ||= nil
if post and post.activity
  json.id post.id
  json.activity_id post.activity.id
  json.medias post.medias do |media|
    json.partial! '/api/medias/media', media: media 
  end
end
