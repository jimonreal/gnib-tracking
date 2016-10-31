# == Schema Information
#
# Table name: availabilities
#
#  id         :integer          not null, primary key
#  count      :integer
#  cat_id     :integer
#  sbcat_id   :integer
#  typ_id     :integer
#  datetime   :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

describe SeekAvaibilities, type: :service do
  pending "add some examples to (or delete) #{__FILE__}"
end
