class Membership < ActiveRecord::Base

  attr_accessible :project_id, :user_id
  belongs_to :project
  belongs_to :user
  
end

# == Schema Information
#
# Table name: memberships
#
#  id         :integer         not null, primary key
#  project_id :integer
#  user_id    :integer
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

