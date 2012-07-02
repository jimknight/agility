# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :stub_user do
    email "stubuser@example.com"
    project_id 1
  end
end
