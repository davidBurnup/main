class AddPreferedCapoToUserSongPreference < ActiveRecord::Migration[4.2]
  def change
    add_column :user_song_preferences, :prefered_capo, :integer
  end
end
