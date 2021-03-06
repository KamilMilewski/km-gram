require 'rails_helper'

feature 'User authentication' do
  background do
    @user = create(:user)
  end

  scenario 'can log in from the index via dynamic navbar' do
    visit 'browse'
    expect(page).to_not have_content('New post')
    click_link 'Log in'
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password
    click_button 'Log in'

    expect(page).to have_content('Signed in successfully.')
    expect(page).to_not have_content('Register')
    expect(page).to have_content('Logout')
  end

  scenario 'can log out once logged in' do
    visit 'browse'
    click_link 'Log in'
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password
    click_button 'Log in'
    click_link 'Logout'

    expect(page).to have_content('You need to sign in or sign up before
    continuing.')
  end

  scenario 'cannot view index posts without logging in' do
    visit 'browse'
    expect(page).to have_content('You need to sign in or sign up before
    continuing.')
  end

  scenario 'cannot create a new post without logging in' do
    visit new_post_path
    expect(page).to have_content('You need to sign in or sign up before
    continuing.')
  end
end
