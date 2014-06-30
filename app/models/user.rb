class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable
  enum role: [:user, :worship_leader, :admin]
  belongs_to :church

  after_initialize :set_default_role, :if => :new_record?
  after_initialize :set_default_church_role

  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100#", :tiny => "50x50#" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/


  has_many :user_song_preferences
  has_one :church_role
  accepts_nested_attributes_for :church_role

  validates :name, :email, :presence => true
  validates :password, :presence => true, :on => :create
  def set_default_role
    self.role ||= :user
  end

  def set_default_church_role
    if church.present? and !self.church_role
      self.build_church_role(:role => :member, :user_id => self.id, :church_id => self.church.id)
    end
  end

  def full_name
    "#{self.first_name.downcase.capitalize} #{self.last_name.downcase.capitalize}"
  end

  def self.current
    Thread.current[:user]
  end
  def self.current=(user)
    Thread.current[:user] = user
  end

  def has_role?(role)
    self.role == role
  end

  def has_church_role?(church_role)
    self.church and self.church_role and self.church_role.church == self.church and self.church_role.role == church_role
  end



end
