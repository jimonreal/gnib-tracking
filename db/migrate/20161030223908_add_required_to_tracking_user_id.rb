class AddRequiredToTrackingUserId < ActiveRecord::Migration[5.0]
  def change
  	change_column_null :trackings, :user_id, false
  end
end
