if @activity
  json.partial! "/api/activities/activity", activity: @activity
end
