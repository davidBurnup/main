class AddFinalizedToUser < ActiveRecord::Migration
  def change
    add_column :users, :is_finalized, :boolean
  end
end
