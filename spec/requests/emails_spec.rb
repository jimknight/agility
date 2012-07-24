require 'spec_helper'

describe "Emails" do
  it "should compose a new email" do
    @user = sign_in_as("user@example.com","abc123")
    @project = FactoryGirl.create(:project, :user_id => @user.id)
    visit project_path(@project)
    click_link "compose email"
    page.should have_content "New"
  end
  it "should create a task from an email and navigate to it" do
    @user = sign_in_as("user@example.com","abc123")
    @project = FactoryGirl.create(:project, :user_id => @user.id)
    @email = FactoryGirl.create(:email)
    @project.emails << @email
    visit project_email_path(@project, @email)
    click_link "Add a task"
    fill_in "Title", :with => "Task from email"
    click_button "Create Task"
    click_link "Task from email"
    page.should have_content("Task from email")
  end
  it "should create a reply to an email and send it" do
    @user = sign_in_as("user@example.com","abc123")
    @project = FactoryGirl.create(:project, :user_id => @user.id)
    @email = FactoryGirl.create(:email)
    @project.emails << @email    
    visit project_email_path(@project, @email)
    click_link "Reply"
    page.should have_content("Reply")
    find_field("email[subject]").value.should == "Re: #{@email.subject}"
    find_field("email[sent_to]").value.should == @email.sent_from
    click_button "Send"
    page.should have_content("Message sent")
  end
  it "should create a reply to all to an email and send it" do
    @project = FactoryGirl.create(:project)
    @email = FactoryGirl.create(:email, :copy_to => "copy@example.com")
    @project.emails << @email
    sign_in_as("user@example.com","abc123")
    visit project_email_path(@project, @email)
    click_link "Reply to All"
    page.should have_content("Reply To All")
    find_field("email[subject]").value.should == "Re: #{@email.subject}"
    find_field("email[sent_to]").value.should == @email.sent_from
    find_field("email[copy_to]").value.should == @email.copy_to
    click_button "Send"
     page.should have_content("Message sent")
  end
  it "should create a forward to an email and send it" do
    @project = FactoryGirl.create(:project)
    @email = FactoryGirl.create(:email, :copy_to => "copy@example.com")
    @project.emails << @email
    sign_in_as("user@example.com","abc123")
    visit project_email_path(@project, @email)
    click_link "Forward"
    page.should have_content("Forward")
    find_field("email[subject]").value.should == "Fw: #{@email.subject}"
    find_field("email[sent_to]").value.should == ""
    find_field("email[copy_to]").value.should == ""
    fill_in "Send to", :with => "jimknight@lavatech.com" 
    click_button "Send"
     page.should have_content("Message sent")
  end
  it "should show the ancestry of emails on the show action" do
    @project = FactoryGirl.create(:project)
    @parent_email = FactoryGirl.create(:email, :subject => "Parent")
    @email = FactoryGirl.create(:email, :subject => "Current")
    @project.emails << @email
    @child_email = FactoryGirl.create(:email, :subject => "Child")
    @parent_email.children << @email
    @email.children << @child_email
    visit project_email_path(@project,@email)
    page.should have_content("Parent")
    page.should have_content("Current")
    page.should have_content("Child")
  end
  it "should hide Reply to All button if no cc" do
    @project = FactoryGirl.create(:project)
    @email = FactoryGirl.create(:email, :copy_to => nil)
    @project.emails << @email
    sign_in_as("user@example.com","abc123")
    visit project_email_path(@project, @email)
    page.should_not have_content("Reply to All")
  end
end