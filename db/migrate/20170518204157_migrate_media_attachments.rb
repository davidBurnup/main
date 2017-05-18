class MigrateMediaAttachments < ActiveRecord::Migration
  def change
    # drop_table :media do |t|
    #   t.timestamps null: false
    # end
    create_table :medias do |t|
      t.integer :post_id
      t.timestamps
    end
    [:image, :pdf, :word, :excel].each do |attachment|
      add_column :medias, "#{attachment}_file_name".to_sym, :string
      add_column :medias, "#{attachment}_content_type".to_sym, :string
      add_column :medias, "#{attachment}_file_size".to_sym, :integer
      add_column :medias, "#{attachment}_updated_at".to_sym, :datetime
    end
  end
end
