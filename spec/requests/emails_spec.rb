require 'spec_helper'

describe "Emails" do
	it "should create a task from an email and navigate to it" do
		@project = FactoryGirl.create(:project)
		@email = FactoryGirl.create(:email)
		@project.emails << @email
		sign_in_as("user@example.com","abc123")
		visit email_path(@email)
		click_link "Add a task"
		fill_in "Title", :with => "Task from email"
		click_link_or_button "Create Task"
		click_link "Task from email"
		page.should have_content("Task from email")
	end
end