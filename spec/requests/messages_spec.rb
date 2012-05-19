require 'spec_helper'

describe "Messages" do
  describe "GET /projects/1/messages" do
    it "should show messages for a project" do
    	@user = sign_in_as("user@example.com","abc123")
    	@project = FactoryGirl.create(:project)
    	5.times do
    		@message = FactoryGirl.create(:message, :content => "chatterbug")
    		@project.messages << @message
        @user.messages << @message  		
    	end
      visit project_messages_path(@project)
      page.should have_content("chatterbug")
      page.should have_content(@user.email)
    end
  end
end
