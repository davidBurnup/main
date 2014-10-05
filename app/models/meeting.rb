class Meeting < ActiveRecord::Base

  has_many :meeting_users
  has_many :practices

  serialize :songs, Array

  accepts_nested_attributes_for :meeting_users, :practices, allow_destroy: true


  def end_at
    Time.at(start_at.to_i + duration) if start_at and start_at.to_i > 0
  end

  def duration_in_hours
  	duration / 3600
  end

end
