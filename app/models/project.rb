class Project < ActiveRecord::Base
  attr_accessible :body, :email, :title, :user_id
end
