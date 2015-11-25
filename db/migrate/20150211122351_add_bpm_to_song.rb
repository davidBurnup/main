class AddBpmToSong < ActiveRecord::Migration
  def change
    add_column :songs, :bpm, :integer
  end
end
