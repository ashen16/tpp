require 'spec_helper'

feature "Creating a post" do
  let!(:user){FactoryGirl.create(:user)}
  let!(:post){FactoryGirl.create(:post)}

  context "as a user" do
    context "with valid input" do
      scenario "allows you to edit a post" do
        sign_in(user)
        visit edit_post_path(post)

        fill_in('title', :with => 'Technology is awesome')
        fill_in('body', :with => 'It can change the world!')
        click_button('Submit')

        page.should have_content('Post was successfully updated.')
        page.should have_content('Technology is awesome')
        page.should have_content('It can change the world!')
      end
    end
  end
  context "as a visitor" do
    context "with valid input" do
      scenario "doesn't allows you to edit a post" do
        visit new_post_path

        page.should have_content('You need to sign in or sign up before continuing.')
        page.should have_no_content('title')
        page.should have_no_content('body')
      end
    end
  end
end
