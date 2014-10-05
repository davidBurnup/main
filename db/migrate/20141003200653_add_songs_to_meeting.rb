class AddSongsToMeeting < ActiveRecord::Migration
  def change
    add_column :meetings, :songs, :text
  end
end
