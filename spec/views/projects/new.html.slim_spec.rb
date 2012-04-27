require 'spec_helper'

describe "projects/new" do
  before(:each) do
    assign(:project, stub_model(Project,
      :title => "MyString",
      :body => "MyText",
      :user_id => 1,
      :email => "MyString"
    ).as_new_record)
  end

  it "renders new project form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => projects_path, :method => "post" do
      assert_select "input#project_title", :name => "project[title]"
      assert_select "textarea#project_body", :name => "project[body]"
      assert_select "input#project_user_id", :name => "project[user_id]"
      assert_select "input#project_email", :name => "project[email]"
    end
  end
end
