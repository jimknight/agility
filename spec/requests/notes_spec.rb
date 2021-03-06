require 'spec_helper'

describe "Notes" do
  it "should find the parent project when nested 2 levels down from a project" do
    @user = sign_in_as("user@example.com","abc123")
    @project = FactoryGirl.create(:project,:user_id => @user.id)
    @note = FactoryGirl.create(:note, :title => "I am the parent note")
    @project.notes << @note
    visit project_note_path(@project, @note)
    click_link "add note"
    fill_in 'Title', :with => "I am the child note"
    click_button "Create Note"
    click_link "I am the child note"
    page.should have_content "I am the child note"
  end
  it "should be able to create a task from a note" do
    @user = sign_in_as("user@example.com","abc123")
    @project = FactoryGirl.create(:project,:user_id => @user.id)
    @note = FactoryGirl.create(:note, :title => "I am the parent note")
    @task = FactoryGirl.create(:task)
    @project.tasks << @task
    @task.notes << @note
    visit task_note_path(@task,@note)
    click_link "add task"
    fill_in "Title", :with => "Task from note"
    click_button "Create Task"
    page.should have_content "I am the parent note"
    @project.tasks.count.should == 2
  end
  it "should prohibit another user from seeing a private note" do
    @user = FactoryGirl.create(:user)
    @note = FactoryGirl.create(:note, :user_id => @user.id)
    @project = FactoryGirl.create(:project, :user_id => @user.id)
    @project.notes << @note
    @other_user = sign_in_as("otheruser@example.com","abc123")
    @project.users << @other_user
    visit project_note_path(@project, @note)
    page.should have_content "You are not authorized to view that note."
  end
  describe "edit" do
    it "should allow the user to define a private note" do
      @user = sign_in_as("user@example.com","abc123")
      @project = FactoryGirl.create(:project,:user_id => @user.id)
      @task = FactoryGirl.create(:task)
      @project.tasks << @task
      visit project_task_path(@project,@task)
      click_link "add note"
      fill_in "Title", :with => "private note"
      choose "audience_private" # stupid capybara
      click_button "Create Note"
      click_link "Sign out"
      @other_user = sign_in_as("otheruser@example.com","abc123")
      @project.users << @other_user
      visit project_task_path(@project,@task)
      page.should_not have_content "private note"
    end
    it "should only show notify team if users" do
      @user = sign_in_as("user@example.com","abc123")
      @project = FactoryGirl.create(:project,:user_id => @user.id)
      visit new_project_note_path(@project)
      page.should_not have_content("Notify the team of this note")
      @teammate = FactoryGirl.create(:user)
      @project.users << @teammate
      visit new_project_note_path(@project)
      page.should have_content("Notify the team of this note")
    end
    it "should show a note and allow user to edit" do
      @user = sign_in_as("user@example.com","abc123")
      @project = FactoryGirl.create(:project, :user_id => @user.id)
      @note = FactoryGirl.create(:note)
      @project.notes << @note
      visit project_note_path(@project, @note)
      click_link "edit note"
      fill_in "Title", :with => "New title"
      click_button "Update Note"
      page.should have_content "New title"
    end
  end
  describe "/projects/1/notes/new" do
    it "should generate a new note from an email" do
      @mgr = sign_in_as("user@example.com","abc123")
      @project = FactoryGirl.create(:project, :user_id => @mgr.id)
      @email = FactoryGirl.create(:email)
      @project.emails << @email
      visit project_email_path(@project, @email)
      click_link "add note"
      page.should have_content "New Note"
    end
    it "should generate a New Note for a project" do
      sign_in_as("user@example.com","abc123")
      visit new_project_path
      fill_in 'Title', :with => 'a new project'
      click_button "Create Project"
      Project.all.size.should == 1
      click_link "add note"
      page.should have_content('New Note')
      fill_in 'Title', :with => 'a New Note for a project'
      click_button "Create Note"
    end
    it "should allow a notification to the team for a New Note" do
      pending # don't know how to test without sending the actual email
      user = sign_in_as("user@example.com","abc123")
      @project = FactoryGirl.create(:project, :user_id => user.id)
      @user = FactoryGirl.create(:user)
      @project.users << @user
      visit project_path(@project)
      click_link "add note"
      fill_in :title, :with => "Note that emails the team"
      check :notify_team
      click_button "Create Note"
      @project.emails.size.should == 1
    end
  end
  describe "/tasks/1/notes/new" do
    it "should generate a New Note for a task" do
      sign_in_as("user@example.com","abc123")
      visit new_project_path
      fill_in 'Title', :with => 'a new project'
      click_button "Create Project"
      click_link "add task"
      fill_in "Title", :with => 'a new task'
      click_button "Create Task"
      click_link "a new task"
      click_link "add note"
      page.should have_content('New Note')
      fill_in 'Title', :with => 'a New Note for a project'
      click_button "Create Note"
    end
  end
  describe "/notes/1/notes/new" do
    it "should generate a New Note for a note" do
      sign_in_as("user@example.com","abc123")
      visit new_project_path
      fill_in 'Title', :with => 'a new project'
      click_button "Create Project"
      click_link "add task"
      fill_in "Title", :with => "Task with grandchild note"
      click_button "Create Task"
      click_link "add note"
      page.should have_content('New Note')
      fill_in 'Title', :with => 'a New Note for a project'
      click_button "Create Note"
      click_link "add note"
      fill_in 'Title', :with => 'a New Note for a note'
      click_button "Create Note"
    end
  end
end
