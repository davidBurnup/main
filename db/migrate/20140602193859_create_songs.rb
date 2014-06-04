class CreateSongs < ActiveRecord::Migration
  def change
    create_table :songs do |t|
      t.string :title
      t.text :content
      t.string :key

      t.timestamps
    end
  end
end
