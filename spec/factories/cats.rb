# == Schema Information
#
# Table name: cats
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :cat do
    name Faker::Commerce.product_name
  end
end
