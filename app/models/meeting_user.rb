class MeetingUser < ApplicationRecord
  belongs_to :user
  belongs_to :meeting

  enum instrument: %w(voice violin trombone trumpet piano acoustic_bass acoustic_guitar electric_guitar electric_bass_guitar drums bongos flute saxophone oboe)

  scope :leaders, lambda {
    where(is_leader: true)
  }
end
