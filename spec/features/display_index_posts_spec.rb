require 'rails_helper.rb'

feature 'index display list of posts' do
  background do
    @user = FactoryGirl.create(:user)
    log_in @user
  end

  scenario 'index correctly displays created posts' do
    post1 = FactoryGirl.create(:post, caption: '#caption 1', user_id: @user.id)
    post2 = FactoryGirl.create(:post, caption: '#caption 2', user_id: @user.id)
    post3 = FactoryGirl.create(:post, caption: '#caption 3', user_id: @user.id)
    visit '/'
    # User can see the comments and images of the posts we have created.
    expect(page).to have_content(post1.caption)
    expect(page).to have_content(post2.caption)
    expect(page).to have_content(post3.caption)
    expect(page).to have_css("img[src*='kitten.png']")
  end

  it 'should redirect to post show page upon clicking post image' do
    post = FactoryGirl.create(:post, user_id: @user.id)
    visit '/'
    # click on an image link
    find(:xpath, "//a[contains(@href, 'posts/#{post.id}')]").click
    # expect to be taken to the show page of our post
    expect(page.current_path).to eq(post_path(post))
    expect(page).to have_content(post.caption)
  end
end
