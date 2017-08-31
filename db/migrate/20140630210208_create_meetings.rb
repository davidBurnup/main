class CreateMeetings < ActiveRecord::Migration[4.2]
  def change
    create_table :meetings do |t|
      t.string :label
      t.datetime :start_at
      t.integer :duration
      t.integer :created_by

      t.timestamps
    end
  end
end
