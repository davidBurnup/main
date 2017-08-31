class AddCleanContentFullIndex < ActiveRecord::Migration[4.2]
  def change
    add_index :songs, :clean_content, name: 'clean_content_full_text', type: :fulltext
  end
end
