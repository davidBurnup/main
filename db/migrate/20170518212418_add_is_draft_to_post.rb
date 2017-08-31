class AddIsDraftToPost < ActiveRecord::Migration[4.2]
  def change
    add_column :posts, :is_draft, :boolean
  end
end
