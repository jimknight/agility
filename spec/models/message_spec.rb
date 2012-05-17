require 'spec_helper'

describe Message do
  it "should belong to a project" do
  	@message = FactoryGirl.create(:message)
  	@message.should respond_to(:project)
  end
  it "should belong to a user" do
  	@message = FactoryGirl.create(:message)
  	@message.should respond_to(:project)
  end
end

# == Schema Information
#
# Table name: messages
#
#  id         :integer         not null, primary key
#  content    :text
#  created_at :datetime        not null
#  updated_at :datetime        not null
#  project_id :integer
#  user_id    :integer
#

