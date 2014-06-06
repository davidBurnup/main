json.array!(@user_song_preferences) do |user_song_preference|
  json.extract! user_song_preference, :id
  json.url user_song_preference_url(user_song_preference, format: :json)
end
