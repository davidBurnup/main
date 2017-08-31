class AddNoteToNote < ActiveRecord::Migration[4.2]
  def change
    add_column :notes, :note, :string
  end
end
