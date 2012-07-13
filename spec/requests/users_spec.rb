require 'spec_helper'

describe "Users" do
	it "should allow a logged in user to edit their profile" do
		@user = sign_in_as("user@example.com","abc123")
		visit edit_user_registration_path
    page.should have_content "Full name"
	end
end
