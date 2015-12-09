class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.references :user, index: true, foreign_key: true
      t.references :song, index: true, foreign_key: true
      t.text :comment
      t.string :link
      t.string :role
      t.string :status
      t.timestamps null: false
    end
  end
end
