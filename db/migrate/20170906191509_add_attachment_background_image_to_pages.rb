class AddAttachmentBackgroundImageToPages < ActiveRecord::Migration[4.2]
  def self.up
    change_table :pages do |t|
      t.attachment :background_image
    end
  end

  def self.down
    remove_attachment :pages, :background_image
  end
end
