class AddIsValidToPages < ActiveRecord::Migration[4.2]
  def change
    add_column :pages, :is_valid, :boolean
  end
end
