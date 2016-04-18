class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.integer :user_id
      t.string  :title
      t.text    :content
      t.boolean :checked, :default => false

      t.timestamps null: false
    end
  end
end
