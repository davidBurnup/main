class AddFinalizedToUser < ActiveRecord::Migration[4.2]
  def change
    add_column :users, :is_finalized, :boolean
  end
end
