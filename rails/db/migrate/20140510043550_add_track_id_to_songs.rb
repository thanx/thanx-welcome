class AddTrackIdToSongs < ActiveRecord::Migration
  def change
    add_column :songs, :track_id, :string
  end
end
