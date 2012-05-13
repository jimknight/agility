require 'spec_helper'

describe Project do
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

