class AddDisplayToSongs < ActiveRecord::Migration
  def change
    add_column :songs, :display, :string, :default => "public", :index => true
  end
end
