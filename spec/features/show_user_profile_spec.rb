require 'rails_helper.rb'

feature 'show user profile' do
  background do
    @user        = create(:user)
    @post        = create(:post, user_id: @user.id)
    @second_user = create(:user)
    @second_post = create(:post, user_id: @second_user.id)
    log_in @user
    visit '/'
    click_link @post.user.name
  end

  scenario 'show user profile page has user name in the url' do
    expect(page.current_path).to eq(profile_path(@user.name))
  end

  scenario 'user profile shows only posts speciffied to user' do
    expect(page).to have_content(@post.user.name)
    expect(page).to have_content(@post.caption)
    expect(page).to_not have_content(@second_post.user.name)
    expect(page).to_not have_content(@second_post.caption)
  end
end
