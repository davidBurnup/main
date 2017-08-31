class CreatePracticeUsers < ActiveRecord::Migration[4.2]
  def change
    create_table :practice_users do |t|
      t.integer :user_id
      t.integer :practice_id
      t.boolean :accepted
      t.boolean :notified

      t.timestamps
    end
  end
end
