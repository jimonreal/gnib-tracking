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

FactoryGirl.define do
  factory :sbcat do
  	name Faker::Commerce.product_name
    cat
  end
end
