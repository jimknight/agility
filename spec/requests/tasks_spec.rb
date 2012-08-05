require 'spec_helper'

describe "Tasks" do
  it "should create and edit from a project" do
    sign_in_as("user@example.com","abc123")
    visit new_project_path
    fill_in "Title", :with => "A project with a task"
    click_link_or_button "Create Project"
    click_link "add task"
    fill_in "Title", :with => "A child task"
    click_link_or_button "Create Task"
    page.should have_content("A project with a task")
    page.should have_content("Successfully created task.")
    click_link "A child task"
    click_link "edit task"
    click_button "Update Task"
    page.should have_content("Task was successfully updated.")
  end
  describe "with an email parent" do
    before(:each) do
      @mgr = sign_in_as("user@example.com","abc123")
      @project = FactoryGirl.create(:project, :user_id => @mgr.id)
      @email = FactoryGirl.create(:email)
      @project.emails << @email      
      visit project_email_path(@project, @email)
      click_link_or_button "Add a task"
      fill_in "Title", :with => "I am a task created from an email"
      click_button "Create Task"
    end
    it "should correctly create a task" do
      page.should have_content(@email.subject)
      page.should have_link("I am a task created from an email")
    end
    it "should have a project_id" do
      Task.last.project_id.should_not be_nil
    end
  end
end