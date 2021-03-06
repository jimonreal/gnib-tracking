# == Schema Information
#
# Table name: availabilities
#
#  id          :integer          not null, primary key
#  cat_id      :integer
#  typ_id      :integer
#  datetime    :datetime
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  external_id :string(255)
#  expired_at  :datetime
#

class Availability < ApplicationRecord
  belongs_to :cat
  belongs_to :typ

  scope :unexpired, -> { where(expired_at: nil) }
  scope :expired, -> { where.not(expired_at: nil) }

  def expired?
    expired_at.present?
  end
end
