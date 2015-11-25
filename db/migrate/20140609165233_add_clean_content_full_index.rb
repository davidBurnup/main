class AddCleanContentFullIndex < ActiveRecord::Migration
  def change
    add_index :songs, :clean_content, name: 'clean_content_full_text', type: :fulltext
  end
end
