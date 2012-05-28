require 'spec_helper'

describe "Messages" do
  before(:each) do
    @user = sign_in_as("user@example.com","abc123")
    @project = FactoryGirl.create(:project)
    5.times do |i|
      @message = FactoryGirl.create(:message, :content => "chatterbug#{i}")
      @project.messages << @message
      @user.messages << @message      
    end
  end
  it "should show messages for a project" do
    visit project_messages_path(@project)
    page.should have_content("chatterbug")
    page.should have_content(@user.email)
  end
  it "can be searched" do
    pending
    visit project_messages_path(@project)
    fill_in "query", :with => "chatterbug1"
    page.should have_link("chatterbug1", :href => project_messages_path(@project))
  end
end
