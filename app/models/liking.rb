class Liking < ActiveRecord::Base

  belongs_to :song, :counter_cache => true
  belongs_to :user, :counter_cache => true

end
