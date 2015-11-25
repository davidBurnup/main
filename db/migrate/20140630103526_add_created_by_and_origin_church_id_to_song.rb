class AddCreatedByAndOriginChurchIdToSong < ActiveRecord::Migration
  def change
    add_column :songs, :created_by, :integer
    add_column :songs, :origin_church_id, :integer
  end
end
