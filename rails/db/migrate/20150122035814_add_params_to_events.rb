class AddParamsToEvents < ActiveRecord::Migration
  def change
    add_column :events, :params, :json
  end
end
