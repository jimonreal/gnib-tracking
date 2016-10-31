class RenameRequestToTracking < ActiveRecord::Migration[5.0]
  def change
  	rename_table :requests, :trackings
  	rename_column :trackings, :requester_id, :user_id
  end
end
