class AddNotificationClickTimeToUser < ActiveRecord::Migration
  def change
    add_column :users, :notification_click_time, :datetime, :default => Time.now

    User.all.each do |user|
      if user.notification_click_time.nil?
        user.notification_click_time = Time.now
        user.save
      end
    end
  end
end
