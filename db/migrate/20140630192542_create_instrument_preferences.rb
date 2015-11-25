class CreateInstrumentPreferences < ActiveRecord::Migration
  def change
    create_table :instrument_preferences do |t|
      t.integer :instrument
      t.integer :user_id
      t.text :detail

      t.timestamps
    end
  end
end
