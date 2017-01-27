require 'rails_helper.rb'

feature 'Creating comments' do
  background do
    user = FactoryGirl.create(:user)
    @post = FactoryGirl.create(:post, user_id: user.id)
    log_in user
    visit '/'
  end

  scenario 'can create comment' do
    comment_content = 'First! lol'
    fill_in 'Comment', with: comment_content
    click_button 'Submit'
    expect(page).to have_css('div.comment', id: "comment_#{@post.id}",
                                            text: comment_content)
  end

  it 'should not allow create empty comments' do
    fill_in 'Comment', with: ''
    click_button 'Submit'
    expect(page).to have_content('Could not create comment.')
  end

  it 'should not allow create comments longer than 250 chars' do
    fill_in 'Comment', with: 'a' * 251
    click_button 'Submit'
    expect(page).to have_content('Could not create comment.')
  end
end
