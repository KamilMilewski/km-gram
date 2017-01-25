require 'rails_helper.rb'

feature 'Creating posts' do
  background do
    visit '/'
    click_link 'New Post'
  end

  scenario 'can create a post' do
    attach_file('image', 'spec/files/images/kitten.png')
    fill_in 'Caption', with: 'sweeeet #dżizas!!!'
    click_button 'Create Post'
    expect(page).to have_content('#dżizas!!!')
    expect(page).to have_css("img[src*='kitten.png']")
  end

  it 'needs an image to crete a post' do
    fill_in 'Caption', with: 'I don\'t wanna post no selfies on scary internet!'
    click_button 'Create Post'
    expect(page).to have_content('Could not create post.')
  end
end
