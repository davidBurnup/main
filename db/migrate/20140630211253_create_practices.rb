class CreatePractices < ActiveRecord::Migration[4.2]
  def change
    create_table :practices do |t|
      t.integer :meeting_id
      t.datetime :start_at
      t.integer :duration
      t.integer :reminder

      t.timestamps
    end
  end
end
