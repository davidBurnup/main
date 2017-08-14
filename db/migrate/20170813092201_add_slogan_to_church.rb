class AddSloganToPage < ActiveRecord::Migration
  def change
    add_column :pages, :slogan, :string
  end
end
