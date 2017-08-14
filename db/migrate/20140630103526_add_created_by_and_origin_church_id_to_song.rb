class AddCreatedByAndOriginPageIdToSong < ActiveRecord::Migration
  def change
    add_column :songs, :created_by, :integer
    add_column :songs, :origin_page_id, :integer
  end
end
