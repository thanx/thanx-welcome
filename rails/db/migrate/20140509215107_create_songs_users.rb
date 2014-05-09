class CreateSongsUsers < ActiveRecord::Migration
  def change
    create_table :songs_users, id: false do |t|
      t.belongs_to :user
      t.belongs_to :song
      t.timestamps
    end
  end
end
