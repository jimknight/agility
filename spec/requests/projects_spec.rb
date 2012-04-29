require 'spec_helper'

describe "Projects" do
  it "should require a title and email address" do
    sign_in_as("user@example.com","abc123")
    visit new_project_path
    click_link_or_button "Submit"
    page.should have_content("can't be blank")
  end
end
