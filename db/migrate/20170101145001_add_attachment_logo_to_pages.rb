class AddAttachmentLogoToPages < ActiveRecord::Migration[4.2]
  def self.up
    change_table :pages do |t|
      t.attachment :logo
    end
  end

  def self.down
    remove_attachment :pages, :logo
  end
end
