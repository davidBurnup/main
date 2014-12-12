class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable
  enum role: [:user, :worship_leader, :admin]
  enum instrument: %w(voice violin trombone trumpet piano acoustic_bass acoustic_guitar electric_guitar electric_bass_guitar drums bongos flute saxophone oboe)
  belongs_to :church

  after_initialize :set_default_role, :if => :new_record?
  after_initialize :set_default_church_role

  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100#", :med_tiny => "75x75#", :tiny => "50x50#", :mini => "39x39#" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

  has_many :user_song_preferences
  has_many :instrument_preferences
  has_many :meeting_users, :dependent => :destroy

  has_one :church_role
  accepts_nested_attributes_for :church_role
  accepts_nested_attributes_for :instrument_preferences, :reject_if => :all_blank, :allow_destroy => true

  validates :name, :email, :presence => true
  validates :password, :presence => true, :on => :create

  scope :leaders, -> {
      where('users.role IN (?) ', [:worship_leader,:admin].map{|r| User.roles[r]})
  }

  acts_as_liker

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

  def name
    at_name = read_attribute(:name)

    if at_name.present?
      at_name = at_name.capitalize
    end

    at_name
  end

  def self.current
    Thread.current[:user]
  end
  def self.current=(user)
    Thread.current[:user] = user
  end

  def has_role?(role)
    self.role == role.to_s
  end

  def is_admin?
    has_role?(:admin)
  end

  def is_up_to_worship_leader?
    is_admin? or has_role?(:worship_leader)
  end

  def has_church_role?(church_role)
    self.church and self.church_role and self.church_role.church == self.church and self.church_role.role == church_role
  end


  def instruments
    if self.instrument_preferences.present?
      return self.instrument_preferences.map{|ip| ip.instrument}
    else
      return InstrumentPreference.instruments.keys
    end
  end



end
