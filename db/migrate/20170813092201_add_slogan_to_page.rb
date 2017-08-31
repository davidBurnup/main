class AddSloganToPage < ActiveRecord::Migration[4.2]
  def change
  	if ActiveRecord::Base.connection.table_exists?(:churches)
	    add_column :churches, :slogan, :string
	else
	    add_column :pages, :slogan, :string
  	end
  end		
end
