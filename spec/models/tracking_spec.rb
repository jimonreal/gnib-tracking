# == Schema Information
#
# Table name: trackings
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  cat_id     :integer
#  sbcat_id   :integer
#  typ_id     :integer
#

require 'rails_helper'

RSpec.describe Tracking, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
