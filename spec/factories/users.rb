# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  email      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  name       :string(255)
#  locale     :string(255)      default("pt-BR")
#

FactoryGirl.define do
  factory :user do
    name Faker::Name.name
    email 'me+1278172908192890@brunobispo.com'
  end
end
