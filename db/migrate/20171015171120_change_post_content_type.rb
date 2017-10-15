class ChangePostContentType < ActiveRecord::Migration[5.1]
  def change
    change_column :posts, :content, :text
  end
end
