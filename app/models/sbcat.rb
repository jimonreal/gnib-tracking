# == Schema Information
#
# Table name: sbcats
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  cat_id     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Sbcat < ApplicationRecord
  belongs_to :cat
end
