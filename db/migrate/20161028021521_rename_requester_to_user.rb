class RenameRequesterToUser < ActiveRecord::Migration[5.0]
  def change
  	rename_table :requesters, :users
  end
end
