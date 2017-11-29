class AddFtIndexesToPagesAndSongs < ActiveRecord::Migration[5.1]

  def self.table_engine(table, engine='InnoDB')
    execute "ALTER TABLE `#{table}` ENGINE = #{engine}"
  end

  def self.up
    table_engine :songs, 'MyISAM'
    table_engine :pages, 'MyISAM'
    add_index(:pages, :name, type: :fulltext)
    add_index(:songs, [:title,:content], type: :fulltext)
  end

  def self.down
    table_engine :songs, 'InnoDB'
    table_engine :pages, 'InnoDB'
    remove_index(:pages, :name)
    remove_index(:songs, column: [:title,:content])
  end

end
