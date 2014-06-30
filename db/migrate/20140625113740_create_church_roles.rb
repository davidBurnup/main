class CreateChurchRoles < ActiveRecord::Migration
  def change
    create_table :church_roles do |t|
      t.integer :user_id
      t.integer :role
      t.integer :church_id

      t.timestamps
    end
  end
end
