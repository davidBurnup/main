class Practice < ActiveRecord::Base
  belongs_to :meeting
  has_many :practice_users

  validates :start_at, :presence => true

  def duration_in_hours
  	duration / 3600
  end

end
