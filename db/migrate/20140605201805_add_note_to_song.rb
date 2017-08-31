class AddNoteToSong < ActiveRecord::Migration[4.2]
  def change
    add_column :songs, :note, :string
  end
end
