require 'spec_helper'

describe "Projects" do
  before (:each) do
    sign_in_as("user@example.com","abc123")
  end
  it "should require a title and email address" do
    visit new_project_path
    click_link_or_button "Submit"
    page.should have_content("can't be blank")
  end
  it "should give a success message when saving" do
    visit new_project_path
    fill_in "Title", :with => "New project"
    click_link_or_button "Submit"
    page.should have_content("Project was successfully created.")
    click_link "Edit this project"
    click_link_or_button "Submit"
    page.should have_content("Project was successfully updated.")
  end
end
