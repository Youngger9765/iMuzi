class CreateMailTitles < ActiveRecord::Migration
  def change
    create_table :mail_titles do |t|
      t.string  :name
      t.string  :subtitle
      t.timestamps null: false
    end
  end
end
