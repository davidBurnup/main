class AddPosterImageToMedia < ActiveRecord::Migration[5.1]
  def change
    add_attachment :medias, :poster_image
  end
end
