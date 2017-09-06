class Page < ApplicationRecord

  include ActsAsFeedOwner
  geocoded_by :address   # can also be an IP address
  after_validation :geocode          # auto-fetch coordinates

  has_many :users
  has_many :page_roles

  has_attached_file :avatar, styles: lambda { |attachment|
    attachment.instance.svg? ? {} : {
      large: "400x400>",
      medium: "200x200#",
      thumb: "100x100#",
      tiny: "50x50#"
    }
  }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/


  has_attached_file :background_image, styles: { cover: "1300x900>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :background_image, content_type: /\Aimage\/.*\z/

  feed_owner({
    title: lambda{|p|
      owner_title = ""
      if p.name.present?
        owner_title = p.name
      end
      owner_title
    }
  })

  scope :valid_for, -> (user) {
    where('pages.is_valid = true OR pages.creator_id = ?', user.id)
  }

  stampable

  def svg?
    self.avatar_content_type === 'image/svg+xml'
  end

  def logo_medium_style
    svg? ? :original : :medium
  end

  def admins
    page_roles.admins
  end

  def is_admin?(user)
    admins.where("page_roles.user_id = ?", user.id).present?
  end
end
