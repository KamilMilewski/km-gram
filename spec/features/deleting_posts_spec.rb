require 'rails_helper'

feature 'Deleting posts' do
  background do
    user = create(:user)
    log_in user
    post = create(:post, user_id: user.id)
    visit 'browse'
    # click on the image to 'show' the individual post
    find(:xpath, "//a[contains(@href, 'posts/#{post.id}')]").click
    click_link 'edit'
  end
  scenario 'can delete post' do
    click_link 'delete'
    expect(page.current_path).to eq(root_path)
    expect(page).to have_content('Post deleted')
    # expect to not see the old post anymore.
    expect(page).to_not have_css("img[src*='kitten.png']")
  end
end
