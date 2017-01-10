json.array!(@instrument_preferences) do |instrument_preference|
  json.partial! "instrument_preference", instrument_preference: instrument_preference
end
