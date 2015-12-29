class AddUseToSongs < ActiveRecord::Migration
  def change
    add_column :songs, :use, :string, :default => "hide"
    add_column :songs, :teacher_choice, :string
  end
end
