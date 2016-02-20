class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :songs, dependent: :destroy
  devise :omniauthable, :omniauth_providers => [:facebook]
  has_one :profile, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :star_records, dependent: :destroy

  has_many :likings, dependent: :destroy
  has_many :like_songs, :through => :likings, :source => :song
  
  after_create :create_profile
  after_create :create_user_star_record

  has_many :mailboxes, dependent: :destroy

  def create_profile
    self.build_profile
    self.profile.username = self.name || self.email.split("@")[0]
    self.profile.role = "normal"
    self.profile.save!
    self.profile
  end

  def create_user_star_record
    star_record = self.star_records.new
    star_record.action = "add_free_star"
    star_record.free_star_count = 1
    star_record.money_star_count = 0
    star_record.save!
    star_record = self.star_records.new
    star_record.action = "add_free_star"
    star_record.free_star_count = 2
    star_record.money_star_count = 0
    star_record.save!
  end

  def free_star_count
    self.star_records.last.free_star_count   
  end 

  def money_star_count
    self.star_records.last.money_star_count   
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

  def teacher?
    self.profile.role == "teacher"
  end

  def like_song?(song)
    self.like_songs.include?(song)
  end

  def photo
    if self.profile.logo && self.profile.logo.exists?
      self.profile.logo
    elsif self.profile.image
      self.profile.image
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
    profile.image = auth.info.image
    profile.username = auth.info.name
    profile.save!

    return user
  end
end
