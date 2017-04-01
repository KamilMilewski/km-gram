require 'rails_helper'

feature 'deleting comments' do
  background do
    user       = create(:user)
    other_user = create(:user)
    post = create(:post, user_id: other_user.id)
    @comment         = create(:comment, post_id: post.id,
                                        user_id: user.id)
    @foreign_comment = create(:comment, post_id: post.id,
                                        user_id: other_user.id)
    log_in user
  end

  scenario 'user can delete his own comments' do
    visit 'browse'
    click_link "delete-#{@comment.id}"
    expect(page).to_not have_content(@comment.content)
  end

  it 'should not allow delete foreign comment via page' do
    visit '/browse'
    expect(page).to have_content(@foreign_comment.content)
    expect(page).to_not have_css "#delete-#{@foreign_comment.id}"
  end

  it 'should not allow delete foreign comment via DELETE request' do
    visit '/browse'
    expect(page).to have_content(@foreign_comment.content)
    page.driver.submit :delete, comment_path(@foreign_comment), {}
    expect(page).to have_content("You can't delete foreign comments.")
    expect(page).to have_content(@foreign_comment.content)
  end
end
