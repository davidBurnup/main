class CreatePosts < ActiveRecord::Migration[4.2]
  def change
    create_table :posts do |t|
      t.text :content
      t.integer :user_id
      t.integer :song_id
      t.string :external_url

      t.timestamps
    end
  end
end
