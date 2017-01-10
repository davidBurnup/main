if instrument_preference
  json.extract! instrument_preference, :id, :detail
  json.instrument_label I18n.t("instruments.#{instrument_preference.instrument}") if instrument_preference.instrument.present?
  json.instrument_enum instrument_preference.instrument
  json.url api_instrument_preference_url(instrument_preference, format: :json)
end
