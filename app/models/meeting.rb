class Meeting < ActiveRecord::Base

  has_many :meeting_users
  has_many :practices

  accepts_nested_attributes_for :meeting_users, :practices, allow_destroy: true

  def start_at
    start_at = read_attribute(:start_at)

    if start_at
      start_at = start_at.strftime("%d/%m/%Y %H:%M")
    end

    start_at
  end
end
