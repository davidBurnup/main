class PageRole < ApplicationRecord
  belongs_to :user
  belongs_to :page
  enum :role => [:member, :moderator, :admin]

  scope :admins, -> {
    where(role: :admin)
  }

end
