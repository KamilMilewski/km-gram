require 'rails_helper.rb'

feature 'Liking ones posts' do
  background do
    @user = create(:user)
    @post = create(:post, user_id: @user.id)
    log_in @user
    visit '/'
  end

  scenario 'can like a post' do
    click_link "like-button-#{@post.id}"
    expect(page).to have_css('a.likes-post')
    # Expect to see my name within the "liked by" area of the post.
    within('div.liked-by') do
      expect(page).to have_content(@user.name)
    end
  end

  scenario 'can unlike a post' do
    click_link "like-button-#{@post.id}"
    expect(page).to have_css('a.likes-post')
    # Expect to see my name within the "liked by" area of the post.
    within('div.liked-by') do
      expect(page).to have_content(@user.name)
    end
    # Click the "like" button once more.
    click_link "like-button-#{@post.id}"
    # Expect to see the "unlikes-post" class on the button.
    expect(page).to have_css('a.unlikes-post')
    # Expect to NOT see my name within the "liked by" area of the post
    within('div.liked-by') do
      expect(page).to_not have_content(@user.name)
    end
  end
end
