class AddExpiredAtToAvailability < ActiveRecord::Migration[5.0]
  def change
    add_column :availabilities, :expired_at, :datetime
    Availability.where(expired: true).update_all('expired_at = created_at')
    remove_column :availabilities, :expired
  end
end
