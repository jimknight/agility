require 'spec_helper'

describe Task do
  it "should have many notes" do
    @project = FactoryGirl.create(:project)
    @task = @project.tasks.create!(:title => "a project task")
    @task.notes.size.should == 0
    @note = @task.notes.create!(:title => "a task note")
    @task.notes.size.should == 1
  end
  it "should belong to project" do
    @project = FactoryGirl.create(:project)
    @task = FactoryGirl.create(:task)
    @project.tasks << @task
    @project.tasks.size.should == 1    
  end
  it "should belong to task" do
    @parent_task = FactoryGirl.create(:task)
    @task = FactoryGirl.create(:task)
    expect { @parent_task.tasks << @task }.to change(@parent_task.tasks, :count).by(1)
    @grandchild_task = FactoryGirl.create(:task)
    expect { @task.children << @grandchild_task }.to change(@task.children, :count).by(1)
  end
  it "should belong to note" do
    @note = FactoryGirl.create(:note)
    @task = FactoryGirl.create(:task)
    expect { @note.tasks << @task }.to change(@note.tasks, :count).by(1)
  end
  it "should belong to email" do
    @email = FactoryGirl.create(:email)
    @task = FactoryGirl.create(:task)
    expect { @email.tasks << @task }.to change(@email.tasks, :count).by(1)
  end
end
# == Schema Information
#
# Table name: tasks
#
#  id              :integer         not null, primary key
#  title           :string(255)
#  body            :text
#  occurrence_date :date
#  taskable_id     :integer
#  taskable_type   :string(255)
#  parent_id       :integer
#  project_id      :integer
#  created_at      :datetime        not null
#  updated_at      :datetime        not null
#  status          :text
#  deadline        :date
#

