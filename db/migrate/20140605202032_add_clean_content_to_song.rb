class AddCleanContentToSong < ActiveRecord::Migration[4.2]
  def change
    add_column :songs, :clean_content, :text
    execute("ALTER TABLE songs ENGINE=MyISAM")
  end
end
