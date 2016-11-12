class AddLastNotificationAtToTracking < ActiveRecord::Migration[5.0]
  def change
    add_column :trackings, :last_notification_at, :datetime
  end
end
