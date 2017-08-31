class CreateMedia < ActiveRecord::Migration[4.2]
  def change
    create_table :media do |t|
      t.integer :post_id

      t.timestamps
    end
  end
end
