class AddLatitudeAndLongitudeToPage < ActiveRecord::Migration[4.2]
  def change
    add_column :pages, :latitude, :float
    add_column :pages, :longitude, :float
  end
end
