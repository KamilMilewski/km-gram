require 'rails_helper.rb'

feature 'Editing posts' do
  background do
    user = create(:user)
    log_in user
    post = create(:post, user_id: user.id)
    visit 'browse'
    # click on the image to 'show' the individual post
    find(:xpath, "//a[contains(@href, 'posts/#{post.id}')]").click
    click_link 'edit'
  end

  scenario 'can edit post as the owner' do
    new_caption = 'Internet is scary!!! I don\'t wanna my pics here :( )'
    fill_in 'Caption', with: new_caption
    click_button 'Update'
    expect(page).to have_content('Post successfully updated.')
    expect(page).to have_content(new_caption)
  end

  it 'should not allow update post without picture' do
    attach_file('post_image', 'spec/files/images/kitten.zip')
    click_button 'Update'
    expect(page).to have_content('Could not update post.')
  end

  it 'should not allow edit foreign post via the show page' do
    foreign_user = create(:user)
    foreign_post = create(:post, user_id: foreign_user.id)
    visit post_path(foreign_post)
    expect(page).to_not have_content('edit')
  end

  it 'should not allow edit foreign post via url' do
    foreign_user = create(:user)
    foreign_post = create(:post, user_id: foreign_user.id)
    visit edit_post_path(foreign_post)
    expect(page).to have_content("That post dosen't belong to you!")
  end
end
