require 'spec_helper'

describe Account do
	before (:each) { @account = FactoryGirl.create(:account) }
  it "should have many projects" do
  	@account.should respond_to(:projects)
  	@project = FactoryGirl.create(:project)
  	@account.projects << @project
  	@account.projects.should == [@project]
  	@project.accounts.should == [@account]
  end
  it "should have many account mgrs (users)" do
  	@account.should respond_to(:users)
  	@user1 = FactoryGirl.create(:user)
  	@user2 = FactoryGirl.create(:user)
  	@account.users << @user1
  	@account.users << @user2
  	@account.users.should == [@user1, @user2]
  	@user1.accounts.should == [@account]
  	@user2.accounts.should == [@account]
  end
  # add the stripe validation to make sure they paid
end
