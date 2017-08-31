class AddWasNotifiedToMeetingUser < ActiveRecord::Migration[4.2]
  def change
    add_column :meeting_users, :was_notified, :boolean
  end
end
