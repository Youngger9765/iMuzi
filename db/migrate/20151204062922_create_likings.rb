class CreateLikings < ActiveRecord::Migration
  def change
    create_table :likings do |t|
      t.integer :song_id, :index => true
      t.integer :user_id, :index => true
      t.timestamps null: false
    end
  end
end
