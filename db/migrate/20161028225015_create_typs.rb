class CreateTyps < ActiveRecord::Migration[5.0]
  def change
    create_table :typs do |t|
      t.string :name

      t.timestamps
    end
  end
end
