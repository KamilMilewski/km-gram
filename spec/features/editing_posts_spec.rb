require 'rails_helper.rb'

feature 'Editing posts' do
  background do
    post = FactoryGirl.create(:post)
    visit '/'
    # click on the image to 'show' the individual post
    find(:xpath, "//a[contains(@href, 'posts/#{post.id}')]").click
    click_link 'edit'
  end

  scenario 'can edit post' do
    new_caption = 'Internet is scary!!! I don\'t wanna my pics here :( )'
    fill_in 'Caption', with: new_caption
    click_button 'Update'
    expect(page).to have_content('Post successfully updated.')
    expect(page).to have_content(new_caption)
  end

  it 'should not allow update post without picture' do
    attach_file('image', 'spec/files/images/kitten.zip')
    click_button 'Update'
    expect(page).to have_content('Could not update post.')
  end
end
