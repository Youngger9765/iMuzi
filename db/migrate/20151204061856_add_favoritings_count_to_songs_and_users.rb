class AddFavoritingsCountToSongsAndUsers < ActiveRecord::Migration
  def change
    add_column :songs, :likings_count, :integer, :default => 0
    add_column :users, :likings_count, :integer, :default => 0
  end
end
