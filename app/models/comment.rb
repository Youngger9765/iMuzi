class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :song
  validates_presence_of :comment
end