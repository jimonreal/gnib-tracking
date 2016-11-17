# == Schema Information
#
# Table name: trackings
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  cat_id     :integer
#  sbcat_id   :integer
#  typ_id     :integer
#

class Tracking < ApplicationRecord
  belongs_to :user
  accepts_nested_attributes_for :user
  
  belongs_to :cat
  belongs_to :sbcat
  belongs_to :typ

  has_secure_token

  scope :activated, -> { where('created_at > ?', 1.month.ago).where(active: true) }

  def availabilities
  	Availability.where cat: cat, typ: typ, expired: false
  end

  def new_availabilities
  	last_notification_at ? availabilities.where('updated_at > ?', last_notification_at) : availabilities
  end

  def mark_as_notified!
    update! last_notification_at: DateTime.now
  end

  def deregister!
    update! active: false
  end
end
