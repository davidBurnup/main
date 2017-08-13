class Church < ActiveRecord::Base

  geocoded_by :address   # can also be an IP address
  after_validation :geocode          # auto-fetch coordinates

  has_many :users
  has_many :church_roles

  has_attached_file :logo, styles: lambda { |attachment|
    attachment.instance.svg? ? {} : {
      large: "400x400>",
      medium: "200x200#",
      thumb: "100x100#"
    }
  }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :logo, content_type: /\Aimage\/.*\z/

  scope :valid_for, -> (user) {
    where('churches.is_valid = true OR churches.creator_id = ?', user.id)
  }

  stampable

  def svg?
    self.logo_content_type === 'image/svg+xml'
  end

  def logo_medium_style
    svg? ? :original : :medium
  end
end
