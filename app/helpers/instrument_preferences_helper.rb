module InstrumentPreferencesHelper

  def instrument_keys_labels
    InstrumentPreference.instrument_keys.each_with_object([]) do |instrument_key, instruments|
      instruments << {
        key: instrument_key,
        label: I18n.t("instruments.#{instrument_key}")
      }
    end
  end
end
