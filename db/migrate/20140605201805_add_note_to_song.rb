class AddNoteToSong < ActiveRecord::Migration
  def change
    add_column :songs, :note, :string
  end
end
