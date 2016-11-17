class AddTokenToTracking < ActiveRecord::Migration[5.0]
  def change
    add_column :trackings, :token, :string, index: true
  end
end
