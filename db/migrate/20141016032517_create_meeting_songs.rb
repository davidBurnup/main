class CreateMeetingSongs < ActiveRecord::Migration[4.2]
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
