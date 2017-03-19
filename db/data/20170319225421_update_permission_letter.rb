class UpdatePermissionLetter < ActiveRecord::Migration
  def self.up
    old_cat = Cat.find_by_name!('Permission Letter')
    other = Cat.find_by_name! 'Other'
    permission_letter = other.sbcats.create! name: 'Permission Letter'
    Tracking.where(cat: old_cat).update_all(cat_id: other.id, sbcat_id: permission_letter.id)
    old_cat.sbcats.all.delete_all
    old_cat.delete
  end

  def self.down
    raise ActiveRecord::IrreversibleMigration
  end
end
