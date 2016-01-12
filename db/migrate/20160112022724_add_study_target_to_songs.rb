class AddStudyTargetToSongs < ActiveRecord::Migration
  def change
    add_column :songs, :study_target, :string, :index => true
  end
end
