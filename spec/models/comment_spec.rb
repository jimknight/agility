require 'spec_helper'

describe Comment do
  it "should belong to other models" do
  	@project = FactoryGirl.create(:project)
  	@task = FactoryGirl.create(:task)
  	@comment = FactoryGirl.create(:comment)
  	@project.should respond_to(:comments)
  	@project.comments << @comment
  	@task.should respond_to(:comments)
  	@task.comments << @comment
  end
end
