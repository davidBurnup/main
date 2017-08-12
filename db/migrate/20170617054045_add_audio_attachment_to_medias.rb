class AddAudioAttachmentToMedias < ActiveRecord::Migration
  def change
    [:audio].each do |attachment|
      add_column :medias, "#{attachment}_file_name".to_sym, :string
      add_column :medias, "#{attachment}_content_type".to_sym, :string
      add_column :medias, "#{attachment}_file_size".to_sym, :integer
      add_column :medias, "#{attachment}_updated_at".to_sym, :datetime
    end
  end
end
