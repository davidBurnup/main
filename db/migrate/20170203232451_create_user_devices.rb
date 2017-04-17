class CreateUserDevices < ActiveRecord::Migration
  def change
    create_table :user_devices do |t|
      t.integer :user_id
      t.string :endpoint
      t.string :auth
      t.string :p256dh
      t.boolean :vapid_enabled

      t.timestamps null: false
    end
  end
end