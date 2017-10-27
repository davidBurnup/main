class AddTranscodingProgressToMedia < ActiveRecord::Migration[5.1]
  def change
    add_column :medias, :transcoding_progress, :float
  end
end
