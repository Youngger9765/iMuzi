class AddGenderToUsers < ActiveRecord::Migration
  def change
    add_column :users, :fb_image, :string
    add_column :users, :gender, :string, :index => true
    add_column :users, :birthday, :string, :index => true
    add_column :users, :location, :string, :index => true
    add_column :users, :job, :string, :index => true
    add_column :users, :locale, :string, :index => true
    add_column :users, :fb_link, :string, :index => true
    add_column :users, :fb_raw, :text
    add_column :users, :fb_extra, :text

    add_column :profiles, :nickname, :string, :index => true
    add_column :profiles, :about, :text, :index => true
    add_column :profiles, :job, :string, :index => true
    add_column :profiles, :gender, :string, :index => true
    add_column :profiles, :birthday, :string, :index => true
    add_column :profiles, :age, :string, :index => true
    add_column :profiles, :locale, :string, :index => true
    add_column :profiles, :fb_link, :string, :index => true
    rename_column :profiles, :fb_image, :image
    change_column :profiles, :location, :string
  end
end
