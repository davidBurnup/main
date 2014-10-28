class AddWasNotifiedToMeetingUser < ActiveRecord::Migration
  def change
    add_column :meeting_users, :was_notified, :boolean
  end
end
