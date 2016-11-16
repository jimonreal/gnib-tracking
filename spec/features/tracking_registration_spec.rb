require 'rails_helper'

feature 'Public registration of a new tracking', type: :feature, js: true do
	scenario 'visitor request a new tracking' do

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

    expect(page).to have_text("Tracking was successfully created.")

	end
end