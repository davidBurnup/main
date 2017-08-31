class AddTransposedKeyAndTransposeOffsetToSong < ActiveRecord::Migration[4.2]
  def change
    add_column :songs, :transposed_key, :string
    add_column :songs, :transpose_offset, :integer
  end
end
