class ActivityVisibility < ApplicationRecord
	belongs_to :activity, class_name: "PublicActivity::Activity"
  enum :visibility => [:everyone, :member, :moderator, :admin]
end
