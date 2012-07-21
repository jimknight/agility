require 'spec_helper'

describe "News"  do
	describe "timeline" do
		before(:each) do
			@user = sign_in_as("user@example.com","abc123")
			@project = FactoryGirl.create(:project, :user_id => @user.id)
		end
		it "should show a new project" do
			visit timeline_path
			page.should have_content(@project.title)
		end
		it "should only show a new project to team members" do
			visit timeline_path
			page.should have_content(@project.title)
			click_link "Sign out"
			@user_who_shouldnt_see = sign_in_as("otheruser@example.com","123abc")
			visit timeline_path
			page.should_not have_content(@project.title)
		end
		it "should show a new email" do
			@email = FactoryGirl.create(:email)
			@project.emails << @email
			visit timeline_path
			page.should have_content(@email.subject)
		end
		it "should show a new task" do
			@task = FactoryGirl.create(:task)
			@project.tasks << @task
			visit timeline_path
			page.should have_content(@task.title)
		end
		it "should show a new note" do
			@note = FactoryGirl.create(:note)
			@project.notes << @note
			visit timeline_path
			page.should have_content(@note.title)
		end
	end
end