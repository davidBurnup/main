class AddSloganToChurch < ActiveRecord::Migration
  def change
    add_column :churches, :slogan, :string
  end
end
