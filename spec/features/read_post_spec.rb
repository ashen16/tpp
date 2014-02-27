require 'spec_helper'

feature "Viewing posts" do
  let!(:user){FactoryGirl.create(:user)}
  let!(:post){FactoryGirl.create(:post)}
  let!(:post2){FactoryGirl.create(:post,
    title: 'Not Published',
    body: 'This test post is not published',
    published: false)}
  let!(:post3){FactoryGirl.create(:post,
    title: 'Another One',
    body: 'This test post is another one',
    published: true)}

  context "as a visitor" do
    scenario "shows only published posts" do
      visit root_path

      page.should have_content('Technology, Psychology, Philosophy')
      page.should have_content('Testing a Post')
      page.should have_content('test')
      page.should have_content('This is a test post with a bunch of words')
      page.should have_content('Another One')
      page.should have_content('This test post is another one')

      page.should have_no_content('Not Published')
      page.should have_no_content('This test post is not published')
    end
    scenario "shows individual published post" do
      visit post_path(post3)

      page.should have_content('Technology, Psychology, Philosophy')
      page.should have_no_content('New Post')
      page.should have_content('Another One')
      page.should have_content('This test post is another one')
    end
  end

  context "as a user" do
    scenario "shows all posts" do
      sign_in(user)
      visit root_path

      page.should have_content('Technology, Psychology, Philosophy')
      page.should have_content('Testing a Post')
      page.should have_content('This is a test post with a bunch of words')
      page.should have_content('Not Published')
      page.should have_content('This test post is not published')
    end
    scenario "shows individual published post" do
      sign_in(user)
      visit post_path(post3)

      page.should have_content('Technology, Psychology, Philosophy')
      page.should have_content('New Post')
      page.should have_content('Another One')
      page.should have_content('This test post is another one')
    end
  end
end
