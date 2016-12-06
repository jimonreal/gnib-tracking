# == Schema Information
#
# Table name: trackings
#
#  id                   :integer          not null, primary key
#  user_id              :integer          not null
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  cat_id               :integer
#  sbcat_id             :integer
#  typ_id               :integer
#  last_notification_at :datetime
#  token                :string(255)
#  active               :boolean          default(TRUE)
#

require 'rails_helper'

RSpec.describe Tracking, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
