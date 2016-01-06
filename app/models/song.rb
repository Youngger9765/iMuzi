class Song < ActiveRecord::Base
  belongs_to :user
  mount_uploader :picture, PictureUploader
  validates_presence_of :name, :link
  validates :introduction, presence: { message: "請簡單介紹你的作品或是提供明確的問題" }
  validate  :picture_size
  has_many :comments, dependent: :destroy
  has_many :star_records

  has_many :likings, dependent: :destroy
  has_many :like_users, :through => :likings , :source => :user

  def view_counts
    song_record = Impression.where("impressionable_type =? AND impressionable_id=?","song",self.id)   
    song_view_size = song_record.size
  end 

  def last_teacher_video_comment
    self.comments.where("role=? AND status=? AND link !=?","teacher","professional","").last
  end

  def user_name
    self.user.profile.username
  end

  def last_pro_comments
    self.comments.where(:status => "professional").last
  end

  def teacher_comments?
    self.comments.where(:status => "professional", :role => "teacher").size > 0
  end

  private
  def picture_size
    if picture.size > 5.megabytes
      errors.add(:picture, "檔案必須小於5MB")
    end
  end
end
