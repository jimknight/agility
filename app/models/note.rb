class Note < ActiveRecord::Base

	attr_accessible :title, :body
	acts_as_tree
  belongs_to :attachable, :polymorphic => true
  belongs_to :project
  has_many :attachments, :as => :attachable, :dependent => :destroy
  has_many :tasks, :as => :taskable, :dependent => :destroy
  accepts_nested_attributes_for :attachments  

end
