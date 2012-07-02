require 'spec_helper'

describe "Sessions" do
	it "should warn a new registration when invalid" do
		visit new_user_registration_path
		click_button "Sign up"
		page.should have_content "Some errors were found, please take a look:"
	end	
end