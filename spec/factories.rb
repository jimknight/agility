FactoryGirl.define do
  factory :email do
    subject "an email subject"
    body "an email body"
    sequence(:sent_from) {|n| "person#{n}@example.com" }
  end
  factory :message do
    content "MyText"
  end
  #Factory.sequence(:email)       {|n| "person#{n}@example.com" }
  factory :project do
    title 'new project'
    body 'here are my new project details'
    email 'project@agilechamp.mailgun.org'
  end
  factory :note do
    title 'a new note'
  end
  factory :task do
    title "a generic task"
    status "Open"
  end
  factory :user do
    password 'simplepassword'
    sequence(:email) {|n| "person#{n}@example.com" }
    full_name "Jim Knight"
  end
end
