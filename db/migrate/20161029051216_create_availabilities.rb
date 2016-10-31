class CreateAvailabilities < ActiveRecord::Migration[5.0]
  def change
    create_table :availabilities do |t|
      t.integer :count
      t.references :cat, foreign_key: true
      t.references :sbcat, foreign_key: true
      t.references :typ, foreign_key: true
      t.datetime :datetime

      t.timestamps
    end
  end
end
