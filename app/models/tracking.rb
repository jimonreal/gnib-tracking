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
#  begin_date           :date
#  end_date             :date
#

class Tracking < ApplicationRecord

  belongs_to :user
  accepts_nested_attributes_for :user
  
  belongs_to :cat
  belongs_to :sbcat
  belongs_to :typ

  validates :begin_date, presence: true, if: :later?
  validates :end_date, presence: true, if: :earlier?

  has_secure_token

  scope :active, -> { where(active: true) }

  enum date_behavior: [:closest, :later, :earlier]

  after_initialize do
    self.date_behavior ||= :closest
  end

  before_validation do
    self.begin_date = nil unless later?
    self.end_date = nil unless earlier?
  end

  def availabilities
  	Availability.where cat: cat, typ: typ, datetime: begin_date...end_date
  end

  def new_availabilities
  	availabilities.where('updated_at > ?', last_notification_at || created_at)
  end

  def mark_as_notified!
    update! last_notification_at: DateTime.now
  end

  def deregister!
    update! active: false
  end

  def begin_date
    super || created_at.try(:to_date)
  end

  def end_date
    super || begin_date.try(:+, 30.days)
  end

  def autosave_associated_records_for_user
    if old_user = User.find_by_email(user.email)
      old_user.update_attributes user.attributes.except('id', 'created_at', 'updated_at')
      self.user = old_user
    else
      user.save!
      self.user = user
    end
  end
end
