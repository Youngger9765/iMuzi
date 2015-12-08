class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :songs, dependent: :destroy
  devise :omniauthable, :omniauth_providers => [:facebook]
  has_one :profile, dependent: :destroy
  has_many :comments, dependent: :destroy

  has_many :likings, dependent: :destroy
  has_many :like_songs, :through => :likings, :source => :song
  after_create :create_profile

  def create_profile
    self.build_profile
    self.profile.username = self.name || self.email
    self.profile.role = "normal"
  end

  def role
    if self.profile != nil
      self.profile.role
    elsif self.profile.nil? == true
      self.profile.try(:role)
    end
  end

  def admin?
    self.profile.role == "admin"
  end

  def like_song?(song)
    self.like_songs.include?(song)
  end

  def photo
    if self.picture
      self.picture
    elsif self.profile && self.profile.fb_image
      self.profile.fb_image
    else
      "head.jpg"
    end
  end

  def self.from_omniauth(auth)
      # Case 1: Find existing user by facebook uid
    user = User.find_by_fb_uid( auth.uid )
    if user
      user.fb_token = auth.credentials.token
    #   user.fb_raw_data = auth
      user.save!
      return user
    end

    # Case 2: Find existing user by email
    existing_user = User.find_by_email( auth.info.email )
    if existing_user
      existing_user.fb_uid = auth.uid
      existing_user.fb_token = auth.credentials.token
      #existing_user.fb_raw_data = auth
      existing_user.save!
      return existing_user
    end

    # Case 3: Create new password
    user = User.new
    user.fb_uid = auth.uid
    user.fb_token = auth.credentials.token
    user.name = auth.info.name
    user.nickname = auth.info.name
    user.email = auth.info.email
    user.password = Devise.friendly_token[0,20]
    #user.fb_raw_data = auth
    user.save!
    profile = user.create_profile
    profile.username = auth.info.name
    profile.fb_image = auth.info.image
    profile.role = "normal"
    profile.save!
    return user
  end
end
