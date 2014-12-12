json.array!(@posts) do |post|
  json.extract! post, :id, :content, :user_id, :song_id, :external_url
  json.url post_url(post, format: :json)
end
