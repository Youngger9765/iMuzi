class Song < ActiveRecord::Base
  belongs_to :user
  mount_uploader :picture, PictureUploader
  validates_presence_of :name, :link
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

  private
  def picture_size
    if picture.size > 5.megabytes
      errors.add(:picture, "檔案必須小於5MB")
    end
  end
end
