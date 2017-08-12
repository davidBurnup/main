class RenameUserIdFromComments < ActiveRecord::Migration
  def change
    rename_column :comments, :user_id, :creator_id
    add_column :comments, :updater_id, :integer
  end
end
