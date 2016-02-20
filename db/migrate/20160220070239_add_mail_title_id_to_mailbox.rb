class AddMailTitleIdToMailbox < ActiveRecord::Migration
  def change
    remove_column :mailboxes, :title
    add_column :mailboxes, :mail_title_id, :integer
  end
end
