class Note < ActiveRecord::Base

	attr_accessible :title, :body
	acts_as_tree
  belongs_to :attachable, :polymorphic => true
  belongs_to :project
  has_many :attachments, :as => :attachable, :dependent => :destroy
  has_many :tasks, :as => :taskable, :dependent => :destroy
  accepts_nested_attributes_for :attachments  

end

# == Schema Information
#
# Table name: notes
#
#  id           :integer         not null, primary key
#  title        :string(255)
#  body         :text
#  notable_id   :integer
#  notable_type :string(255)
#  parent_id    :integer
#  created_at   :datetime        not null
#  updated_at   :datetime        not null
#

