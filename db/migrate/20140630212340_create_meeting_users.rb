class CreateMeetingUsers < ActiveRecord::Migration
  def change
    create_table :meeting_users do |t|
      t.integer :user_id
      t.integer :meeting_id
      t.integer :instrument
      t.boolean :accepted

      t.timestamps
    end
  end
end
