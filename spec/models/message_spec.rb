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
