require 'spec_helper'

describe "Projects" do
  before (:each) do
    @user = sign_in_as("user@example.com","abc123")
  end
  it "should not show the login prompt later in the process" do
     visit new_project_path
    fill_in "Title", :with => "New project"
    click_link_or_button "Create Project"
    visit projects_path
    click_link "New project"
    page.should_not have_content("Signed in successfully.")
  end
  it "should allow the creator of the project to add users" do
    visit new_project_path
    fill_in "Title", :with => "New project"
    click_link_or_button "Create Project"
        # TODO js
    # @project = Project.last
    # visit project_path(@project)
    # page.should have_content("Team")
    # page.should have_content("(Captain) user@example.com")
    # click_link("Add team member")
    # fill_in :email, :with => "newuser@example.com"
    # click_link_or_button "Search"
    # page.should have_content("newuser@example.com")
    # page.should have_content("was added")
  end
  it "should allow a team member to see another project" do
     visit new_project_path
    fill_in "Title", :with => "New project"
    click_link_or_button "Create Project"
    # TODO js
    # @project = Project.last
    # visit project_path(@project)
    # page.should have_content("New project")
    # click_link "Logout"
    # @new_team_member = sign_in_as("new-member@example.com","password")
    # @project.users << @new_team_member
    # visit projects_path
    # page.should have_content("New project")
    # page.should have_content("Signed in as new-member@example.com")
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
    pending "if decide to add Persistent Chat"
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
