class AddIsSeenToNotification < ActiveRecord::Migration
  def change
    add_column :notifications, :is_seen, :boolean
  end
end
