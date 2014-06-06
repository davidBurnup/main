class AddCleanContentToSong < ActiveRecord::Migration
  def change
    add_column :songs, :clean_content, :text
  end
end
