class AddDescriptionToPages < ActiveRecord::Migration[5.1]
  def change
    add_column :pages, :description, :text
  end
end
