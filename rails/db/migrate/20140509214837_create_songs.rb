class CreateSongs < ActiveRecord::Migration
  def change
    create_table :songs do |t|
      t.string :path
      t.string :title
      t.string :artist

      t.timestamps
    end
  end
end
