class AddAddressToPage < ActiveRecord::Migration[4.2]
  def change
    add_column :pages, :address, :string
  end
end
