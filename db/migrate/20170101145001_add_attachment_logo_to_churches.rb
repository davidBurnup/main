class AddAttachmentLogoToPages < ActiveRecord::Migration
  def self.up
    change_table :pages do |t|
      t.attachment :logo
    end
  end

  def self.down
    remove_attachment :pages, :logo
  end
end
