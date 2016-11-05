class RemoveUnusedColumnsAvailability < ActiveRecord::Migration[5.0]
  def change
  	change_table :availabilities do |t|
      t.remove_references :sbcat, foreign_key: true
      t.remove :count
    end
  end
end
