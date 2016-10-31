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

require 'rails_helper'

RSpec.describe Sbcat, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
