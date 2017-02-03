require 'rails_helper'

feature 'Public registration of a new tracking', type: :feature, js: true do
  scenario 'visitor request a new tracking' do

    sbcat = create(:sbcat, name: 'English Language Course', cat: create(:cat, name: 'Study'))
    typ = create(:typ, name: 'New')

    visit root_path

    page.driver.header 'Accept-Language', 'en-AU,en-US;q=0.7,en;q=0.3'

    fill_in 'Your name', with: 'Bruno', exact: false
    fill_in 'Your email', with: 'me@brunobispo.com', exact: false
    select 'Study', from: 'Category', match: :first, exact: false
    select 'English Language Course', from: 'Sub Category', exact: false
    select 'New', from: 'Type', exact: true, match: :first
    check 'tracking_user_attributes_eula'

    click_button "Alert me"

    expect(page).to have_text("Tracking was successfully created")

    expect(User.first.locale).to eq('en')
  end

  scenario 'visitor request a different tracking' do
    user = create(:user, email: 'me@brunobispo.com')
    tracking = create(:tracking, user: user)

    sbcat = create(:sbcat, name: 'English Language Course', cat: create(:cat, name: 'Study'))
    typ = create(:typ, name: 'New')

    visit root_path

    fill_in 'Your name', with: 'Bruno', exact: false
    fill_in 'Your email', with: 'me@brunobispo.com', exact: false
    select 'Study', from: 'Category', match: :first, exact: false
    select 'English Language Course', from: 'Sub Category', exact: false
    select 'New', from: 'Type', exact: true, match: :first
    check 'tracking_user_attributes_eula'

    click_button "Alert me"

    expect(page).to have_text("Tracking was successfully created")
    
    expect(User.count).to be 1
    expect(user.trackings.count).to be 2
  end
end

feature 'Unregistration of a tracking', type: :feature do
  scenario 'visitor visit the unregistration page' do
    tracking = create(:tracking)

    visit deregister_tracking_path(tracking.token)

    expect(page).to have_text("Tracking was successfully deregistered")    
  end
end