require 'spec_helper'

describe Project do
  it "should belong to an account" do
    Project.new.should respond_to(:account)
  end
  it "should have many users" do
    @project = FactoryGirl.create(:project)
    @user1 = FactoryGirl.create(:user)
    @user2 = FactoryGirl.create(:user)
    @project.users << @user1
    @project.users << @user2
    @project.users.count.should == 2
  end
  it "should have only unique users" do
    pending #don't know how to test this
    @project = FactoryGirl.create(:project)
    @user1 = FactoryGirl.create(:user)
    @project.users << @user1
    expect {@project.users << @user1}.to raise_error
  end
  it "should have many notes" do
    @project = FactoryGirl.create(:project)
    @project.should respond_to(:notes)
    @note = @project.notes.create!(:title => "a project note")
    @project.notes.size.should == 1
  end
  it "should have many emails" do
    @project = FactoryGirl.create(:project)
    @email = FactoryGirl.create(:email)
    @project.emails << @email
    @project.emails.last.should == @email 
  end
  it "should have an email address" do
    @project = FactoryGirl.create(:project, :email => "project1@example.com")
    @project.email.should == "project1@example.com" 
  end
  it "should have a unique email address" do
    @project = FactoryGirl.create(:project, :email => "project1@example.com")
    @project2 = FactoryGirl.build(:project, :email => @project.email)
    @project2.should_not be_valid
  end
  it "should have many messages" do
    @project = FactoryGirl.create(:project)
    @project.should respond_to(:messages)
  end
  describe "#project_copy_to" do
    it "should compute the correct copy_to email" do
      @project = FactoryGirl.create(:project, :email => "acdivoca@agilechamp.mailgun.org")
      @email = FactoryGirl.create(:email)
      @project.project_copy_to(@email.id).should == "acdivoca-#{@email.id}@agilechamp.mailgun.org"
    end
  end
end
# == Schema Information
#
# Table name: projects
#
#  id         :integer         not null, primary key
#  title      :string(255)
#  body       :text
#  user_id    :integer
#  email      :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

