class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string  :username
      t.integer :user_id
      t.integer :location
      t.string :status
      t.string :fb_image
      t.string :role
      t.timestamps null: false
    end

    add_index :profiles, :status
    add_index :profiles, :user_id
    add_index :profiles, :location
    add_index :profiles, :role
  end
end
