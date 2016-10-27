class CreateRequests < ActiveRecord::Migration[5.0]
  def change
    create_table :requests do |t|
      t.references :requester, foreign_key: true
      t.string :cat
      t.string :sbcat
      t.string :type

      t.timestamps
    end
  end
end
