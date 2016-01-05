class AddDisplayToComments < ActiveRecord::Migration
  def change
    add_column :comments, :display, :string, :default => "public", :index => true
  end
end
