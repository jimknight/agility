require 'spec_helper'

describe "Notes" do
  describe "edit" do
    it "should show a note and allow user to edit" do
      @user = sign_in_as("user@example.com","abc123")
      @project = FactoryGirl.create(:project, :user_id => @user.id)
      @note = FactoryGirl.create(:note)
      @project.notes << @note
      visit project_note_path(@project, @note)
      click_link "Edit this note"
      fill_in "Title", :with => "New title"
      click_button "Update Note"
      page.should have_content "New title"
    end
  end
  describe "/projects/1/notes/new" do
    it "should generate a new note for a project" do
      sign_in_as("user@example.com","abc123")
      visit new_project_path
      fill_in 'Title', :with => 'a new project'
      click_link_or_button "Create Project"
      Project.all.size.should == 1
      click_link_or_button "Add a note"
      page.should have_content('New note')
      fill_in 'Title', :with => 'a new note for a project'
      click_button "Create Note"
    end
    it "should allow a notification to the team for a new note" do
      pending # don't know how to test without sending the actual email
      user = sign_in_as("user@example.com","abc123")
      @project = FactoryGirl.create(:project, :user_id => user.id)
      @user = FactoryGirl.create(:user)
      @project.users << @user
      visit project_path(@project)
      click_link_or_button "Add a note"
      fill_in :title, :with => "Note that emails the team"
      check :notify_team
      click_button "Create Note"
      @project.emails.size.should == 1
    end
  end
  describe "/tasks/1/notes/new" do
    it "should generate a new note for a task" do
       sign_in_as("user@example.com","abc123")
       visit new_project_path
       fill_in 'Title', :with => 'a new project'
      click_link_or_button "Create Project"
       click_link_or_button "Add a task"
       fill_in "Title", :with => 'a new task'
      click_link_or_button "Create Task"
       click_link "a new task"
       click_link_or_button "Add a note"
       page.should have_content('New note')
       fill_in 'Title', :with => 'a new note for a project'
       click_button "Create Note"
    end
  end
  describe "/notes/1/notes/new" do
    it "should generate a new note for a note" do
      sign_in_as("user@example.com","abc123")
      visit new_project_path
      fill_in 'Title', :with => 'a new project'
      click_link_or_button "Create Project"
      click_link_or_button "Add a note"
      page.should have_content('New note')
      fill_in 'Title', :with => 'a new note for a project'
      click_button "Create Note"
      click_link_or_button "Add a note"
      page.should have_content('New note')
      fill_in 'Title', :with => 'a new note for a note'
      click_button "Create Note"
    end
  end
end
