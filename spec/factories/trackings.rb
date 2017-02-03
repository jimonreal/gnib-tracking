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

FactoryGirl.define do
  factory :tracking do
    user
    cat
    typ
    sbcat
    created_at 1.second.ago

    factory :tracking_with_availabilities do
      transient do
        availabilities_count 3
      end

      after(:create) do |tracking, evaluator|
        create_list(:availability, evaluator.availabilities_count, cat: tracking.cat, typ: tracking.typ)
      end
    end
  end
end
