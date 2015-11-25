class AddNoteToNote < ActiveRecord::Migration
  def change
    add_column :notes, :note, :string
  end
end
