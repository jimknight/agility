require 'spec_helper'

describe Email do
  describe ".send_email" do
    it "should correctly send an email to someone" do
      @project = FactoryGirl.create(:project)
      @email = FactoryGirl.create(:email)
      @project.emails << @email
      expect {Email.send_email(@email,"jimknight@lavatech.com")}.to change(Email.sent, :count).by(1)
    end
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

