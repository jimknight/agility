require 'spec_helper'

describe "Tasks" do
  describe "with an email parent" do
    before(:each) do
      @project = Factory(:project)
      @email = Factory(:email)
      @project.emails << @email
      sign_in_as("user@example.com","abc123")
       visit project_email_path(@project, @email)
       click_link_or_button "Add a task"
       fill_in "Title", :with => "I am a task created from an email"
       click_button "Create Task"
    end
    it "should correctly create a task" do
       page.should have_text(@email.subject)
       page.should have_link("I am a task created from an email")
    end
    it "should have a project_id" do
       Task.last.project_id.should_not be_nil
    end
  end
end