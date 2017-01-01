class Church < ActiveRecord::Base

  geocoded_by :address   # can also be an IP address
  after_validation :geocode          # auto-fetch coordinates

  has_many :users
  has_many :church_roles

  has_attached_file :logo, styles: {
    medium: "300x300#",
    thumb: "100x100#"
  }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :logo, content_type: /\Aimage\/.*\z/

  scope :valid_for, -> (user) {
    where('churches.is_valid = true OR churches.creator_id = ?', user.id)
  }

  stampable
end
