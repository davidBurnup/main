class AddAuthorToSong < ActiveRecord::Migration[4.2]
  def change
    add_column :songs, :author, :string
  end
end
