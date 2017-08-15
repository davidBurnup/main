class Practice < ApplicationRecord
  belongs_to :meeting
  has_many :practice_users

  def duration_in_hours
  	duration / 3600
  end

end
