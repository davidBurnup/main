class CreateActivityVisibilities < ActiveRecord::Migration[5.1]
  def change
    create_table :activity_visibilities do |t|
      t.integer :activity_id
      t.integer :visibility

      t.timestamps
    end
  end
end
