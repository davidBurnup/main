class AddSloganToPage < ActiveRecord::Migration[4.2]
  def change
    add_column :churches, :slogan, :string
  end
end
