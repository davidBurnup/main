class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.integer :song_id
      t.integer :line
      t.integer :offset

      t.timestamps
    end
  end
end
