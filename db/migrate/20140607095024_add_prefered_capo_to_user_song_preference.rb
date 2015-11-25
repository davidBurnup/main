class AddPreferedCapoToUserSongPreference < ActiveRecord::Migration
  def change
    add_column :user_song_preferences, :prefered_capo, :integer
  end
end
