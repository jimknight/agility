require 'spec_helper'

describe "Projects" do
  before (:each) do
    @user = sign_in_as("user@example.com","abc123")
  end
  it "should require a title and email address" do
    visit new_project_path
    click_link_or_button "Create Project"
    page.should have_content("can't be blank")
  end
  it "should give a success message when saving" do
    visit new_project_path
    fill_in "Title", :with => "New project"
    click_link_or_button "Create Project"
    page.should have_content("Project was successfully created.")
    click_link "Edit this project"
    click_link_or_button "Update Project"
    page.should have_content("Project was successfully updated.")
  end
  it "should show the latest messages and a link to all" do
    @project = FactoryGirl.create(:project)
    @user.projects << @project
    10.times do
      @message = FactoryGirl.create(:message, :content => "Chat it up")
      @project.messages << @message
      @user.messages << @message
    end
    visit project_path(@project)
    page.should have_link("Persistent Chat", :href => project_messages_path(@project))
    page.should have_content("Chat it up")
  end
end
