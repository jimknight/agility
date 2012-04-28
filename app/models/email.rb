class Email < ActiveRecord::Base
  
  attr_accessible :body, :copy_to, :project_id, :sent_from, :sent_to, :subject
  alias_attribute :title, :subject
  belongs_to :project
  has_many :attachments, :as => :attachable, :dependent => :destroy
  has_many :tasks, :as => :taskable, :dependent => :destroy
  accepts_nested_attributes_for :attachments

end

# == Schema Information
#
# Table name: emails
#
#  id         :integer         not null, primary key
#  subject    :text
#  body       :text
#  sent_from  :text
#  sent_to    :text
#  copy_to    :text
#  project_id :integer
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

