require 'rails_helper'

feature 'Public registration of a new tracking', type: :feature do
	scenario 'visitor request a new tracking' do

    Capybara.exact = false

    visit root_path

    fill_in 'E-mail', with: 'me@brunobispo.com'
    select 'Study', from: 'Category', match: :first
    select 'English Language Course', from: 'Sub Category'
    select 'New', from: 'Type'

    click_button "Track Availability"

    expect(page).to have_text("Tracking was successfully created.")

	end
end