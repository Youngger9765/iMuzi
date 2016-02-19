class CreateMailboxes < ActiveRecord::Migration
  def change
    create_table :mailboxes do |t|
      t.integer  :user_id
      t.string   :title
      t.string   :user_email
      t.text     :content   
      t.timestamps null: false
    end
  end
end
