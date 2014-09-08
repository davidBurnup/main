class Practice < ActiveRecord::Base
  belongs_to :meeting
  has_many :practice_users

end
