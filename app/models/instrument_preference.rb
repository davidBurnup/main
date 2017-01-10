class InstrumentPreference < ActiveRecord::Base

  belongs_to :user

  enum instrument: %w(voice violin trombone trumpet piano acoustic_bass acoustic_guitar electric_guitar electric_bass_guitar drums bongos flute saxophone oboe)

  scope :for_user, -> (user) {
    where(user_id: user.id)
  }
end
