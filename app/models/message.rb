class Message < ActiveRecord::Base

  attr_accessible :content
  belongs_to :project
  belongs_to :user

end

# == Schema Information
#
# Table name: messages
#
#  id         :integer         not null, primary key
#  content    :text
#  created_at :datetime        not null
#  updated_at :datetime        not null
#  project_id :integer
#  user_id    :integer
#

