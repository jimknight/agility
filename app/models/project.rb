class Project < ActiveRecord::Base

  attr_accessible :body, :email, :title
  belongs_to :user
  has_many :emails
  has_many :notes, :as => :notable, :dependent => :destroy
  has_many :tasks, :dependent => :destroy
  validates_uniqueness_of :email, :case_sensitive => false
  
end

# == Schema Information
#
# Table name: projects
#
#  id         :integer         not null, primary key
#  title      :string(255)
#  body       :text
#  user_id    :integer
#  email      :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

