class AddPageIdToUser < ActiveRecord::Migration[4.2]
  def change
    add_column :users, :page_id, :integer
  end
end
