class Account < ActiveRecord::Base

  attr_accessible :tier, :title

  has_and_belongs_to_many :projects
  has_many :subscriptions
  has_many :users, :through => :subscriptions

end
