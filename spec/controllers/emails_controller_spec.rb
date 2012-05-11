require 'spec_helper'

describe EmailsController do
  describe "POST #create" do
    it "saves to the right place from mailgun" do
      @project = Factory(:project, :email => "acdivoca@agilechamp.mailgun.org")
      @parent_email = Factory(:email)
      #post :create, email: Factory.attributes_for(:email)
      # response.should redirect_to root_url
      post :create, { 
        "recipient"=>"acdivoca-#{@parent_email.id}@agilechamp.mailgun.org", 
        "sender"=>"jimknight@lavatech.com",
        "subject"=>"test",
        "from"=>"Jim Knight <jimknight@lavatech.com>",
        "body-html" => "Jim was <b>here</b>." }
      Email.last.parent.should == @parent_email
      @project.emails.count.should == 1
      # create an original email
      # post a new one in there with the right settings
      # make sure it has the original email as parent
    end
  end
end