class AddIsValidToChurches < ActiveRecord::Migration
  def change
    add_column :churches, :is_valid, :boolean
  end
end
