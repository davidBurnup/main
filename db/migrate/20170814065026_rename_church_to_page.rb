class RenameChurchToPage < ActiveRecord::Migration[4.2]
  def change
    rename_table :churches, :pages
    rename_table :church_roles, :page_roles
    rename_column :users, :church_id, :page_id
    rename_column :page_roles, :church_id, :page_id
    rename_column :songs, :origin_church_id, :origin_page_id
  end
end
