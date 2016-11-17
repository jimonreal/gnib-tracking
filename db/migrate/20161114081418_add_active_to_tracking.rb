class AddActiveToTracking < ActiveRecord::Migration[5.0]
  def change
    add_column :trackings, :active, :boolean, default: true
  end
end
