class CreateUserSongPreferences < ActiveRecord::Migration[4.2]
  def change
    create_table :user_song_preferences do |t|
      t.integer :song_id
      t.integer :user_id
      t.string :prefered_key

      t.timestamps
    end
  end
end
