class CreateMeetingSongs < ActiveRecord::Migration
  def change
    create_table :meeting_songs do |t|
      t.integer :song_id
      t.integer :meeting_id
      t.integer :leader_id
      t.string :key

      t.timestamps
    end
  end
end
