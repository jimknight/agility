class StubUser < ActiveRecord::Base

  attr_accessible :email
  has_and_belongs_to_many :projects

end
