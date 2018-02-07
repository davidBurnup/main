class ActivityVisibility < ApplicationRecord
	belongs_to :activity, class_name: "PublicActivity::Activity"
  enum :visibility => [:everyone, :member, :moderator, :admin, :self]

  before_save :set_default_visibility

  def set_default_visibility
  	self.visibility ||= :self
  end
end
