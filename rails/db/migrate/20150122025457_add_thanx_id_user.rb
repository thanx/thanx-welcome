class AddThanxIdUser < ActiveRecord::Migration
  def change
    add_column :users, :thanx_id, :integer
    add_index :users, :thanx_id
  end
end
