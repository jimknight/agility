require 'spec_helper'

describe MailGun do
  describe ".create_mailbox" do
    it "should create a new mailbox in mailgun given a certain name" do
      response = MailGun.create_mailbox("testproject")
      JSON.parse(response)["message"].should == "Created 1 mailboxes"
    end
    it "should delete a mailbox given a certain name" do
      response = MailGun.delete_mailbox("testproject")
      JSON.parse(response)["message"].should == "Mailbox has been deleted"
      JSON.parse(response)["spec"].should == "testproject@agilechamp.mailgun.org"
    end
  end
end