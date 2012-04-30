require 'spec_helper'

describe "Tasks" do
  it "should create and edit from a project" do
    sign_in_as("user@example.com","abc123")
    visit new_project_path
    fill_in "Title", :with => "A project with a task"
    click_link_or_button "Submit"
    click_link "Add a task"
    fill_in "Title", :with => "A child task"
    click_link_or_button "Submit"
    page.should have_content("A project with a task")
    page.should have_content("Successfully created task.")
    click_link "A child task"
    click_link "Edit this task"
    click_link_or_button "Submit"
    page.should have_content("Task was successfully updated.")
  end
  describe "with an email parent" do
    before(:each) do
      @project = FactoryGirl.create(:project)
      @email = FactoryGirl.create(:email)
      @project.emails << @email
      sign_in_as("user@example.com","abc123")
       visit project_email_path(@project, @email)
       click_link_or_button "Add a task"
       fill_in "Title", :with => "I am a task created from an email"
       click_link_or_button "Submit"
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