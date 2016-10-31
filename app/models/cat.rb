# == Schema Information
#
# Table name: cats
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Cat < ApplicationRecord
	has_many :sbcats
  accepts_nested_attributes_for :sbcats
end
