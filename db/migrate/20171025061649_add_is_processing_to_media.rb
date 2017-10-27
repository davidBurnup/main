class AddIsProcessingToMedia < ActiveRecord::Migration[5.1]
  def change
    add_column :medias, :video_processing, :boolean
  end
end
