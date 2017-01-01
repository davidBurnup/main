class AddStampableToChurches < ActiveRecord::Migration
  def change
    add_column :churches, :creator_id, :integer
    add_column :churches, :updater_id, :integer
  end
end
