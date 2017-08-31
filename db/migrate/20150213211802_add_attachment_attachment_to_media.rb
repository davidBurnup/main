class AddAttachmentAttachmentToMedia < ActiveRecord::Migration[4.2]
  def self.up
    change_table :media do |t|
      t.attachment :attachment
    end
  end

  def self.down
    drop_attached_file :media, :attachment
  end
end
