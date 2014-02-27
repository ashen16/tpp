require 'spec_helper'

feature "Deleting a post" do
  let!(:user){FactoryGirl.create(:user)}
  let!(:post){FactoryGirl.create(:post)}

  context "as a user" do
    scenario "allows you to delete a post" do
      sign_in(user)
      visit root_path

      page.find(:xpath, "/html/body/div/div[2]/div[2]/div/a[3]").click
    end
  end
  context "as a visitor" do
    scenario "should not allows you to delete a post" do
      visit root_path

      page.should have_no_xpath('/html/body/div/div[2]/div[2]/div/a[3]')
    end
  end
end
