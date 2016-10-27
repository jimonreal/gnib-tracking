# == Schema Information
#
# Table name: requests
#
#  id           :integer          not null, primary key
#  requester_id :integer
#  cat          :string(255)
#  sbcat        :string(255)
#  type         :string(255)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

require 'test_helper'

class RequestTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
