class Comment < ActiveRecord::Base
  
  validate :comment_or_link_or_logo

  has_attached_file :logo, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :logo, content_type: /\Aimage\/.*\Z/

  belongs_to :user
  belongs_to :song

  def comment_or_link_or_logo
    if comment.blank? && link.blank? && logo_file_name.nil?
       errors[:base] << "文字，作品連結，照片 請擇一"
    end
  end

  def link_url
    if self.link 
      "https://www.youtube.com/watch?v="+self.link
    end
  end
end
