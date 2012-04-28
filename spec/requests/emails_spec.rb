require 'spec_helper'

describe "Emails" do
	it "should create a task from an email and navigate to it" do
		@project = Factory(:project)
		@email = Factory(:email)
		@project.emails << @email
		sign_in_as("user@example.com","abc123")
		visit email_path(@email)
		click_link "Add a task"
		fill_in "Title", :with => "Task from email"
		click_button "Create Task"
		click_link "Task from email"
		page.should have_content("Task from email")
	end
end