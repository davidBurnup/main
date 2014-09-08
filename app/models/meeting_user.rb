class MeetingUser < ActiveRecord::Base
  belongs_to :user
  belongs_to :meeting

  enum instrument: %w(violin trombone trumpet piano acoustic_bass acoustic_guitar electric_guitar electric_bass_guitar drums bongos flute saxophone oboe)

end
