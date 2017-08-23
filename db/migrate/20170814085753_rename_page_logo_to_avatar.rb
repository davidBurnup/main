class RenamePageLogoToAvatar < ActiveRecord::Migration[4.2]
  def change
    rename_column :pages, :logo_file_name, :avatar_file_name
    rename_column :pages, :logo_content_type, :avatar_content_type
    rename_column :pages, :logo_file_size, :avatar_file_size
    rename_column :pages, :logo_updated_at, :avatar_updated_at
  end
end
