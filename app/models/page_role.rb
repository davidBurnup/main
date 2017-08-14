class PageRole < ActiveRecord::Base
  belongs_to :user
  belongs_to :page
  enum :role => [:member, :moderator]


end
