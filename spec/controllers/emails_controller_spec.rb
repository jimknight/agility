require 'spec_helper'

describe EmailsController do
  describe "POST #create" do
    it "saves to the right place from mailgun" do
      @project = FactoryGirl.create(:project, :email => "acdivoca@agilechamp.mailgun.org")
      @parent_email = FactoryGirl.create(:email)
      post :create, { 
        "recipient"=>"acdivoca-#{@parent_email.id}@agilechamp.mailgun.org", 
        "sender"=>"jimknight@lavatech.com",
        "subject"=>"test",
        "from"=>"Jim Knight <jimknight@lavatech.com>",
        "body-html" => "Jim was <b>here</b>." }
      Email.last.parent.should == @parent_email
      @project.emails.count.should == 1
    end
  end
end