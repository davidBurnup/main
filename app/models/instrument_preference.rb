class InstrumentPreference < ActiveRecord::Base

  belongs_to :user

  def self.instrument_keys
    %w(voice violin trombone trumpet piano acoustic_bass acoustic_guitar electric_guitar electric_bass_guitar drums bongos flute saxophone oboe)
  end
  enum instrument: instrument_keys

  scope :for_user, -> (user) {
    where(user_id: user.id)
  }


end
