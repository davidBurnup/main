class AddIsSeenToNotification < ActiveRecord::Migration[4.2]
  def change
    add_column :notifications, :is_seen, :boolean
  end
end
