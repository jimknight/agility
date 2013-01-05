# clear database
Project.destroy_all

# fill database
user = User.find_by_email("ibmlotusnotes@gmail.com")
10.times do
  project = FactoryGirl.create(:project, :email => Faker::Internet.email, :user_id => user, :title => Faker::Lorem.sentence)
  rand(10).times do
    task = FactoryGirl.create(:task, :title => Faker::Lorem.sentence)
    project.tasks << task
  end
  rand(10).times do
    email = FactoryGirl.create(:email, :title => Faker::Lorem.sentence, :body_text => Faker::Lorem.paragraph(rand(10)))
    project.emails << email
  end
end

# tell user
puts "Seeded! I hope you don't miss the projects you just destroyed."