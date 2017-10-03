class AddSocialsToPage < ActiveRecord::Migration[5.1]
  def change
    add_column :pages, :youtube_url, :string
    add_column :pages, :twitter_url, :string
    add_column :pages, :facebook_url, :string
    add_column :pages, :patreon_url, :string
  end
end
