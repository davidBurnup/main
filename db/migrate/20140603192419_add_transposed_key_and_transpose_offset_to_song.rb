class AddTransposedKeyAndTransposeOffsetToSong < ActiveRecord::Migration
  def change
    add_column :songs, :transposed_key, :string
    add_column :songs, :transpose_offset, :integer
  end
end
