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

FactoryGirl.define do
  factory :availability do
    cat
    typ
    datetime { DateTime.now }
    expired false
  end
end
