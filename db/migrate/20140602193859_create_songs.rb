class CreateSongs < ActiveRecord::Migration[4.2]
  def change
    create_table(:songs, :options => 'ENGINE=InnoDB DEFAULT CHARSET=utf8') do |t|
      t.string :title
      t.text :content
      t.string :key

      t.timestamps
    end

  end
end
