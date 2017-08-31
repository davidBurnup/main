class AddStampableToPages < ActiveRecord::Migration[4.2]
  def change
    add_column :pages, :creator_id, :integer
    add_column :pages, :updater_id, :integer
  end
end
