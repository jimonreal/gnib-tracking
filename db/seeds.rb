# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Cat.create!(name: 'Other').sbcats.create! [
  {name: 'Lost Card'},
  {name: 'Stolen Card'},
  {name: 'Join family member'}
]

Cat.create!(name: 'Permission Letter').sbcats.create! [
  {name: 'Atypical Working schemes'},
  {name: 'Defacto Relationship'},
  {name: 'Doctors'},
  {name: 'Elderly Dependent Relatives'},
  {name: 'EU Treaty Rights'},
  {name: 'Extension of visitor conditions'},
  {name: 'Granted Refugees'},
  {name: 'Subsidiary protection'},
  {name: 'Invest or Start a Business'},
  {name: 'Join my child who is an Irish citizen'},
  {name: 'Join my partner or family member'},
  {name: 'Leave to Remain'},
  {name: 'Persons of Independent Means'},
  {name: 'Religious Ministry'},
  {name: 'Visiting Academics'},
  {name: 'Volunteer e.g. in a charity'}
]

Cat.create!(name: 'Study').sbcats.create! [
  {name: 'PhD'},
  {name: 'Masters'},
  {name: 'Higher National Diploma'},
  {name: 'Degree'},
  {name: 'English Language Course'},
  {name: 'Second Level'},
  {name: 'Pre-Masters'},
  {name: 'Visiting Students'},
  {name: '3rd Level Graduate Scheme'}
]

Cat.create!(name: 'Work').sbcats.create! [
  {name: 'Work Permit Holder'},
  {name: 'Hosting agreement'},
  {name: 'Working Holiday'},
  {name: 'Atypical Working Schemes'},
  {name: 'Invest or Start a Business'},
  {name: 'Visiting Academics'},
  {name: 'Doctor'},
  {name: '3rd Level Graduate Scheme'}
]

Typ.create! [{name: 'New'}, {name: 'Renewal'}]

if Rails.env.development?
  rand(50..100).times do
    cat = Cat.offset(rand Cat.count).first
    created = Availability.create!(
      cat: cat,
      typ: Typ.offset(rand Typ.count).first,
      created_at: rand((7.days.ago)..(1.second.ago)),
      datetime: rand((1.months.from_now)..(2.months.from_now))
    )
    Availability.where(cat: created.cat, typ: created.typ).where.not(id: created.id).update_all(expired: true)
  end
end