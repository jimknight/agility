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

# == Schema Information
#
# Table name: comments
#
#  id               :integer         not null, primary key
#  body             :text
#  user_id          :integer
#  commentable_id   :integer
#  commentable_type :string(255)
#  created_at       :datetime        not null
#  updated_at       :datetime        not null
#

