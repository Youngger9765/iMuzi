class Mailbox < ActiveRecord::Base

  belongs_to :user
  belongs_to :mail_title
  validates :user_email, presence: { message: '請填寫信箱' }
  validates :content, presence: { message: '請填寫內容' }
  validates_format_of :user_email, :with => /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i, :message =>"信箱格式錯誤"
end
