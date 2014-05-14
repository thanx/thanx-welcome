class AddStartAtAndEndAtToSongs < ActiveRecord::Migration
  def change
    add_column :songs, :start_at, :decimal, precision: 8, scale: 2, default: 0.0
    add_column :songs, :end_at, :decimal, precision: 8, scale: 2, default: 10.0
  end
end
