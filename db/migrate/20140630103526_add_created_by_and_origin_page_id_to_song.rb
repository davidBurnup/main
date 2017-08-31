class AddCreatedByAndOriginPageIdToSong < ActiveRecord::Migration[4.2]
  def change
    add_column :songs, :created_by, :integer
    add_column :songs, :origin_page_id, :integer
  end
end
