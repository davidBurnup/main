class AddIsLeaderAndIsCoLeaderToMeetingUser < ActiveRecord::Migration
  def change
    add_column :meeting_users, :is_leader, :boolean
    add_column :meeting_users, :is_co_leader, :boolean
  end
end
