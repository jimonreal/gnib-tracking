class AddExpiredToAvailability < ActiveRecord::Migration[5.0]
  def change
    add_column :availabilities, :expired, :boolean, default: false
  end
end
