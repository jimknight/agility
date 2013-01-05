require 'spec_helper'

describe Note do
  it "should have many attachments" do
    @email = Email.new
    @email.should respond_to(:attachments) 
  end
  it "should have many notes" do
    @project = FactoryGirl.create(:project)
    @note = @project.notes.create!(:title => "a project note")
    @note_baby = FactoryGirl.create(:note)
    @note.children.size.should == 0
    @note.children << @note_baby
    @note.children.size.should == 1
    @note_grandbaby = FactoryGirl.create(:note)
    @note_baby.children << @note_grandbaby
    @note_baby.children.size.should == 1
    @note.descendants.size.should == 2
  end
  it "should have many emails" do
    @project = FactoryGirl.create(:project)
    @email = FactoryGirl.create(:email)
    @note = @project.notes.create!(:title => "a project note")
    @note.emails << @email
    @note.emails.last.should == @email 
  end
end

# == Schema Information
#
# Table name: notes
#
#  id           :integer         not null, primary key
#  title        :string(255)
#  body         :text
#  notable_id   :integer
#  notable_type :string(255)
#  parent_id    :integer
#  created_at   :datetime        not null
#  updated_at   :datetime        not null
#  user_id      :integer
#

