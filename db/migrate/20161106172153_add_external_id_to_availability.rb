class AddExternalIdToAvailability < ActiveRecord::Migration[5.0]
  def change
    add_column :availabilities, :external_id, :string
  end
end
