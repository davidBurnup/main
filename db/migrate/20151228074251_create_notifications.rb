class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.string :notifiable_type
      t.integer :notifiable_id
      t.integer :notifier_id
      t.integer :notified_id

      t.timestamps
    end
  end
end
