require 'spec_helper'

describe "Notes" do
  describe "/projects/1/notes/new" do
    it "should generate a new note for a project" do
      sign_in_as("user@example.com","abc123")
      visit new_project_path
      fill_in 'Title', :with => 'a new project'
      click_link_or_button "Submit"
      Project.all.size.should == 1
      click_link_or_button "Add a note"
      page.should have_content('New note')
      fill_in 'Title', :with => 'a new note for a project'
      click_button "Create Note"
    end
  end
  describe "/tasks/1/notes/new" do
    it "should generate a new note for a task" do
       sign_in_as("user@example.com","abc123")
       visit new_project_path
       fill_in 'Title', :with => 'a new project'
      click_link_or_button "Submit"
       click_link_or_button "Add a task"
       fill_in "Title", :with => 'a new task'
      click_link_or_button "Submit"
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
      click_link_or_button "Submit"
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
