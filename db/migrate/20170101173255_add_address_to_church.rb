class AddAddressToChurch < ActiveRecord::Migration
  def change
    add_column :churches, :address, :string
  end
end
