class CreateSbcats < ActiveRecord::Migration[5.0]
  def change
    create_table :sbcats do |t|
      t.string :name
      t.references :cat, foreign_key: true

      t.timestamps
    end
  end
end
