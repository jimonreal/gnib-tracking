class AddBeginDateAndEndDateToTracking < ActiveRecord::Migration[5.0]
  def change
    add_column :trackings, :begin_date, :date
    add_column :trackings, :end_date, :date
  end
end
