require 'spec_helper'

describe "Emails" do
  # it "should show the inbound and sent messages on the project" do
  #   @user = sign_in_as("user@example.com","abc123")
  #   @project = FactoryGirl.create(:project, :email => "acdivoca@agilechamp.mailgun.org", :user_id => @user.id)
  #   @sent_email = FactoryGirl.create(:email, :subject => "Sent out", :email_type => "sent")
  #   @inbox_email = FactoryGirl.create(:email, :subject => "Sent in", :email_type => "received")
  #   @project.emails << @sent_email
  #   @project.emails << @inbox_email
  #   visit project_path(@project)
  #   page.should have_content "Sent in"
  #   page.should have_content "Sent out" # it would be nice with js test but didn't work right
  # end
  it "should show the cc value on the show page for email if there is one" do
    @user = sign_in_as("user@example.com","abc123")
    @project = FactoryGirl.create(:project, :email => "acdivoca@agilechamp.mailgun.org", :user_id => @user.id)
    @email = FactoryGirl.create(:email, :copy_to => "Jim Knight <jim.knight@lavatech.com>",:sent_to => "wscarano@sga.com")
    @project.emails << @email
    visit project_email_path(@project,@email)
    page.should have_content("wscarano@sga.com")
    page.should have_content("Jim Knight <jim.knight@lavatech.com>")
  end
  it "should show body content text" do
    @user = sign_in_as("user@example.com","abc123")
    @project = FactoryGirl.create(:project, :email => "acdivoca@agilechamp.mailgun.org", :user_id => @user.id)
    @email = FactoryGirl.create(:email, :body_text => "Content goes here")
    @project.emails << @email
    visit project_email_path(@project,@email)
    page.should have_content "Content goes here"
  end
  it "should show attachments" do
    @user = sign_in_as("user@example.com","abc123")
    @project = FactoryGirl.create(:project, :email => "acdivoca@agilechamp.mailgun.org", :user_id => @user.id)
    @email = FactoryGirl.create(:email)
    file_path = Rails.root.join('spec','fixtures','Document1.docx')
    attachment = Attachment.create(:file => File.open(file_path))
    @email.attachments << attachment
    @project.emails << @email
    visit project_email_path(@project,@email)
    page.should have_link "Document1.docx"
  end
  # it "should compose a new email" do
  #   @user = sign_in_as("user@example.com","abc123")
  #   @project = FactoryGirl.create(:project, :user_id => @user.id)
  #   visit project_path(@project)
  #   click_link "compose email"
  #   page.should have_content "New"
  #   fill_in "Send to", :with => "jknight@lavatech.com"
  #   fill_in "Subject", :with => "composing a new email test"
  #   click_button "Send"
  #   page.should have_content "Message sent"
  # end
  # it "should create a task from an email and navigate to it" do
  #   @user = sign_in_as("user@example.com","abc123")
  #   @project = FactoryGirl.create(:project, :user_id => @user.id)
  #   @email = FactoryGirl.create(:email)
  #   @project.emails << @email
  #   visit project_email_path(@project, @email)
  #   click_link "Add a task"
  #   fill_in "Title", :with => "Task from email"
  #   click_button "Create Task"
  #   click_link "Task from email"
  #   page.should have_content("Task from email")
  # end
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
  # it "should create a reply to all to an email and send it" do
  #   @project = FactoryGirl.create(:project)
  #   @email = FactoryGirl.create(:email, :copy_to => "copy@example.com")
  #   @project.emails << @email
  #   sign_in_as("user@example.com","abc123")
  #   visit project_email_path(@project, @email)
  #   click_link "Reply to All"
  #   page.should have_content("Reply To All")
  #   find_field("email[subject]").value.should == "Re: #{@email.subject}"
  #   find_field("email[sent_to]").value.should == @email.sent_from
  #   find_field("email[copy_to]").value.should == @email.copy_to
  #   click_button "Send"
  #    page.should have_content("Message sent")
  # end
  # it "should create a forward to an email and send it" do
  #   @project = FactoryGirl.create(:project)
  #   @email = FactoryGirl.create(:email, :copy_to => "copy@example.com")
  #   @project.emails << @email
  #   sign_in_as("user@example.com","abc123")
  #   visit project_email_path(@project, @email)
  #   click_link "Forward"
  #   page.should have_content("Forward")
  #   find_field("email[subject]").value.should == "Fw: #{@email.subject}"
  #   find_field("email[sent_to]").value.should == ""
  #   find_field("email[copy_to]").value.should == ""
  #   fill_in "Send to", :with => "jimknight@lavatech.com" 
  #   click_button "Send"
  #    page.should have_content("Message sent")
  # end
  # it "should show the ancestry of emails on the show action" do
  #   @project = FactoryGirl.create(:project)
  #   @parent_email = FactoryGirl.create(:email, :subject => "Parent")
  #   @email = FactoryGirl.create(:email, :subject => "Current")
  #   @project.emails << @email
  #   @child_email = FactoryGirl.create(:email, :subject => "Child")
  #   @parent_email.children << @email
  #   @email.children << @child_email
  #   visit project_email_path(@project,@email)
  #   page.should have_content("Parent")
  #   page.should have_content("Current")
  #   page.should have_content("Child")
  # end
  # it "should hide Reply to All button if no cc" do
  #   @project = FactoryGirl.create(:project)
  #   @email = FactoryGirl.create(:email, :copy_to => nil)
  #   @project.emails << @email
  #   sign_in_as("user@example.com","abc123")
  #   visit project_email_path(@project, @email)
  #   page.should_not have_content("Reply to All")
  # end
end