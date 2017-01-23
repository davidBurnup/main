json.array!(@activities) do |activity|
  json.partial! "activity", activity: activity
  json.url api_activity_url(activity, format: :json)
end
