class CreatePageRoles < ActiveRecord::Migration[4.2]
  def change
    create_table :page_roles do |t|
      t.integer :user_id
      t.integer :role
      t.integer :page_id

      t.timestamps
    end
  end
end
