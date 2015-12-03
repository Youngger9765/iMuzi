class AddProfileToUsers < ActiveRecord::Migration
  def change
    add_column :users, :name, :string
    add_column :users, :nickname, :string
    add_column :users, :picture, :string
    add_column :users, :about, :text
    add_column :users, :address, :string
  end
end
