require 'rails_helper.rb'

feature 'Creating users' do
  background do
    visit 'browse'
    click_link 'Register'
  end

  scenario 'can create new user via the index page' do
    fill_in 'Name', with: 'newusername'
    fill_in 'Email', with: 'newusername@email.com'
    fill_in 'Password', with: 'supersecret', match: :first
    fill_in 'Password confirmation', with: 'supersecret'
    click_button 'Sign up'
    expect(page).to have_content('Welcome! You have signed up successfully.')
  end

  scenario 'requires a user name to successfully create an account' do
    fill_in 'Email', with: 'newusername@email.com'
    fill_in 'Password', with: 'supersecret', match: :first
    fill_in 'Password confirmation', with: 'supersecret'
    click_button 'Sign up'
    expect(page).to have_content("can't be blank")
  end

  scenario 'requires a user name to have at least 4 characters' do
    fill_in 'Name', with: 'h'
    fill_in 'Email', with: 'newusername@email.com'
    fill_in 'Password', with: 'supersecret', match: :first
    fill_in 'Password confirmation', with: 'supersecret'
    click_button 'Sign up'
    expect(page).to have_content('minimum is 4 characters')
  end

  scenario 'requires a user name to have no more than 25 characters' do
    fill_in 'Name', with: 'h' * 26
    fill_in 'Email', with: 'newusername@email.com'
    fill_in 'Password', with: 'supersecret', match: :first
    fill_in 'Password confirmation', with: 'supersecret'
    click_button 'Sign up'
    expect(page).to have_content('maximum is 25 characters')
  end
end
