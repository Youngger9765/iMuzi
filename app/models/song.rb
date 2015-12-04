class Song < ActiveRecord::Base
  belongs_to :user
  mount_uploader :picture, PictureUploader
  validates_presence_of :name, :link, :introduction
  validate  :picture_size

  private


  def picture_size
    if picture.size > 5.megabytes
      errors.add(:picture, "檔案必須小於5MB")
    end
  end
end