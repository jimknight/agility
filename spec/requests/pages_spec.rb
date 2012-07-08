require 'spec_helper'

describe "Pages" do
  it "should have a plans page" do
  	visit plans_path
  	page.should have_content ("Plans")
  end
end
