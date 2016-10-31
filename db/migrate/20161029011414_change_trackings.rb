class ChangeTrackings < ActiveRecord::Migration[5.0]
  def change
    change_table :trackings do |t|
      t.remove :cat
      t.remove :sbcat
      t.remove :type
      t.references :cat, foreign_key: true
      t.references :sbcat, foreign_key: true
      t.references :typ, foreign_key: true
    end
  end
end
