require 'spec_helper'

describe "Accounts" do
	describe "Access" do
		before (:each) do
	  	@user = sign_in_as("user1@example.com","abc123")
	  	@account = FactoryGirl.create(:account, :title => "New account")
	  	@account.users << @user
		end
	  it "should only be readable by account managers" do
	  	visit account_path(@account)
	  	page.should have_content "New account"
	  	click_link "Logout"
	  	sign_in_as("user2@example.com","abc123")
	  	visit account_path(@account)
	  	page.should_not have_content "New account"
	  	page.should have_content "Not authorized"
	  end
	  it "should only be editable by account managers" do
	  	visit edit_account_path(@account)
	  	page.should have_content "Edit account"
	  	click_link "Logout"
	  	sign_in_as("user2@example.com","abc123")
	  	visit edit_account_path(@account)
	  	page.should_not have_content "New account"
	  	page.should have_content "Not authorized"
	  end
	end
end