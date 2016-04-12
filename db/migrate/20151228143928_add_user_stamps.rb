class AddUserStamps < ActiveRecord::Migration
  def change
    add_column :meetings, :creator_id, :integer, default: nil
    add_column :meetings, :updater_id, :integer, default: nil

    add_column :posts, :creator_id, :integer, default: nil
    add_column :posts, :updater_id, :integer, default: nil

    add_column :songs, :creator_id, :integer, default: nil
    add_column :songs, :updater_id, :integer, default: nil
  end
end
