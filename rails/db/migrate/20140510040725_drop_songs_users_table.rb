class DropSongsUsersTable < ActiveRecord::Migration
  def change
    drop_table :songs_users
  end
end
