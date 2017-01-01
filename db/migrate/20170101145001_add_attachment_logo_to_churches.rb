class AddAttachmentLogoToChurches < ActiveRecord::Migration
  def self.up
    change_table :churches do |t|
      t.attachment :logo
    end
  end

  def self.down
    remove_attachment :churches, :logo
  end
end
