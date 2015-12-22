class CreateStarRecords < ActiveRecord::Migration
  def change
    create_table :star_records do |t|
      t.integer     :user_id
      t.string      :action
      t.string      :status
      t.integer     :free_star_count
      t.integer     :money_star_count
      t.timestamps null: false
    end
  end
end
