require 'spec_helper'

describe Project do
  it "should have many notes" do
    @project = Factory(:project)
    @project.should respond_to(:notes)
    @note = @project.notes.create!(:title => "a project note")
    @project.notes.size.should == 1
  end
  it "should have many emails" do
    @project = Factory(:project)
    @email = Factory(:email)
    @project.emails << @email
    @project.emails.last.should == @email 
  end
  it "should have an email address" do
    @project = Factory(:project, :email => "project1@example.com")
    @project.email.should == "project1@example.com" 
  end
  it "should have a unique email address" do
    @project = Factory(:project, :email => "project1@example.com")
    @project2 = Factory.build(:project, :email => @project.email)
    @project2.should_not be_valid
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

