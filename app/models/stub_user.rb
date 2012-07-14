class StubUser < ActiveRecord::Base

  attr_accessible :email
  has_and_belongs_to_many :projects

end

# == Schema Information
#
# Table name: stub_users
#
#  id         :integer         not null, primary key
#  email      :string(255)
#  project_id :integer
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

