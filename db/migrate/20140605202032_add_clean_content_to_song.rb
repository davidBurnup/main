class AddCleanContentToSong < ActiveRecord::Migration
  def change
    add_column :songs, :clean_content, :text
    execute("ALTER TABLE songs ENGINE=MyISAM")
  end
end
