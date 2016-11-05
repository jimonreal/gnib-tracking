# == Schema Information
#
# Table name: availabilities
#
#  id         :integer          not null, primary key
#  cat_id     :integer
#  typ_id     :integer
#  datetime   :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  expired    :boolean          default(FALSE)
#

class Availability < ApplicationRecord
  belongs_to :cat
  belongs_to :typ
end
