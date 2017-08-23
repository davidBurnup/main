class AddIsValidToPages < ActiveRecord::Migration
  def change
    add_column :pages, :is_valid, :boolean
  end
end
