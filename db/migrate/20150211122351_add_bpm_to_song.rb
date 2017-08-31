class AddBpmToSong < ActiveRecord::Migration[4.2]
  def change
    add_column :songs, :bpm, :integer
  end
end
