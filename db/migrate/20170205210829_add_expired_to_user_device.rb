class AddExpiredToUserDevice < ActiveRecord::Migration
  def change
    add_column :user_devices, :expired, :boolean
  end
end
