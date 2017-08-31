class AddExpiredToUserDevice < ActiveRecord::Migration[4.2]
  def change
    add_column :user_devices, :expired, :boolean
  end
end
