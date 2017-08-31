class AddDeletedAtToNotifications < ActiveRecord::Migration[4.2]
  def change
    add_column :notifications, :deleted_at, :datetime
    add_index :notifications, :deleted_at
  end
end
