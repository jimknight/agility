class Email < ActiveRecord::Base
  
  attr_accessible :body, :copy_to, :project_id, :sent_from, :sent_to, :subject
  alias_attribute :title, :subject
  belongs_to :project
  has_many :attachments, :as => :attachable, :dependent => :destroy
  has_many :tasks, :as => :taskable, :dependent => :destroy
  accepts_nested_attributes_for :attachments

end
