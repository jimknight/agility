require 'spec_helper'

describe "Messages" do
  describe "GET /projects/1/messages" do
    it "should show messages for a project" do
    	@project = FactoryGirl.create(:project)
    	5.times do
    		@message = FactoryGirl.create(:message, :content => "chatterbug")
    		@project.messages << @message
    	end
    	sign_in_as("user@example.com","abc123")
      visit project_messages_path(@project)
      page.should have_content("chatterbug")
    end
  end
end
