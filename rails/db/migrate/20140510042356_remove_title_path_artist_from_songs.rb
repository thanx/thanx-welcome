class RemoveTitlePathArtistFromSongs < ActiveRecord::Migration
  def change
    remove_column :songs, :title, :string
    remove_column :songs, :path, :string
    remove_column :songs, :artist, :string
  end
end
