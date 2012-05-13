class Message < ActiveRecord::Base

  attr_accessible :content
  belongs_to :project
  belongs_to :user

end
