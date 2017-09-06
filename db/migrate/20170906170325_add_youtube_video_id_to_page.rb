class AddYoutubeVideoIdToPage < ActiveRecord::Migration[5.1]
  def change
    add_column :pages, :youtube_video_id, :string
  end
end
