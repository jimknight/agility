require 'spec_helper'

describe Email do
  describe ".send_email" do
    it "should correctly send an email to someone" do
      @project = FactoryGirl.create(:project)
      @email = FactoryGirl.create(:email, :sent_to => "jimknight@lavatech.com")
      @project.emails << @email
      response = @email.send_email
      JSON.parse(response)["message"].should == "Queued. Thank you."
    end
  end
    it "should have many emails" do
      @project = FactoryGirl.create(:project)
      @email = FactoryGirl.create(:email)
      @project.emails << @email
      @email_baby = FactoryGirl.create(:email)
      @email.children.size.should == 0
      @email.children << @email_baby
      @email.children.size.should == 1
      @email_grandbaby = FactoryGirl.create(:email)
      @email_baby.children << @email_grandbaby
      @email_baby.children.size.should == 1
      @email.descendants.size.should == 2
  end
end

# == Schema Information
#
# Table name: emails
#
#  id         :integer         not null, primary key
#  subject    :text
#  body       :text
#  sent_from  :text
#  sent_to    :text
#  copy_to    :text
#  project_id :integer
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

