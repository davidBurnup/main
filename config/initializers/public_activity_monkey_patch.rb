module PublicActivity
  class Activity < inherit_orm("Activity")
    acts_as_likeable
    acts_as_commentable
  end
end