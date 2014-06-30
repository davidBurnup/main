class ChurchRole < ActiveRecord::Base
  belongs_to :user
  belongs_to :church
  enum :role => [:member, :moderator]


end
