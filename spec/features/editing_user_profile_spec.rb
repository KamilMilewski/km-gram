require 'rails_helper'

feature 'editing user profiles' do
  background do
    @user        = create(:user)
    @post        = create(:post, user_id: @user.id)
    @second_user = create(:user)
    @second_post = create(:post, user_id: @second_user.id)
    log_in @user
    visit '/'
  end

  scenario 'user can edit his own profile' do
    click_link @user.name
    click_link 'Edit Profile'
    expect(page).to have_content('Choose new profile image')
    attach_file('user_avatar', 'spec/files/images/kitten_avatar.jpg')
    new_bio = "What's up bros?!"
    fill_in 'user_bio', with: new_bio
    click_button 'Update Profile'
    expect(page.current_path).to eq(profile_path(@user.name))
    expect(page).to have_css("img[src*='kitten_avatar.jpg']")
    expect(page).to have_content(new_bio)
  end

  scenario 'user can not edit others user profile' do
    click_link @second_user.name
    expect(page).to_not have_content('Edit Profile')
  end

  scenario 'user can not enter other user profile page directly via url' do
    visit edit_profile_path(@second_user.name)
    expect(page).to_not have_content 'Change your avatar:'
    expect(page.current_path).to eq(root_path)
    expect(page).to have_content("That profile dosen't belong to you!")
  end
end
