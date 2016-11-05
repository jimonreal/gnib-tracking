# == Schema Information
#
# Table name: trackings
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  cat_id     :integer
#  sbcat_id   :integer
#  typ_id     :integer
#

class Tracking < ApplicationRecord
  belongs_to :user
  accepts_nested_attributes_for :user
  
  belongs_to :cat
  belongs_to :sbcat
  belongs_to :typ
end
