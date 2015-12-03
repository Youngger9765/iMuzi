class CreateSongs < ActiveRecord::Migration
  def change
    create_table :songs do |t|
      t.string :name
      t.string :singer
      t.text :introduction
      t.string :link
      t.string :picture
      t.integer :views_count
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
