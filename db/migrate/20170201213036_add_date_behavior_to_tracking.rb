class AddDateBehaviorToTracking < ActiveRecord::Migration[5.0]
  def change
    add_column :trackings, :date_behavior, :integer, null: false, default: 0
  end
end
