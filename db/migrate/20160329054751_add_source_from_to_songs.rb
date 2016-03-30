class AddSourceFromToSongs < ActiveRecord::Migration
  def change
    add_column :songs, :source, :string

    Song.all.each do |song|
      if song.source.nil?
        song.source = "youtube"
        song.save
      end
    end
  end
end
