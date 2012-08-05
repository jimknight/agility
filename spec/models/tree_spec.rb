require 'spec_helper'

describe Tree do
	
	it "should find the parent project from a deep note" do
		@project = FactoryGirl.create(:project)
		@task = FactoryGirl.create(:task)
		@note = FactoryGirl.create(:note)
		@grandchild_note = FactoryGirl.create(:note)
		@project.tasks << @task
		@task.notes << @note
		@note.children << @grandchild_note
		Tree.top(@task).should == @project
		Tree.top(@note).should == @project
		Tree.top(@grandchild_note).should == @project
	end

end