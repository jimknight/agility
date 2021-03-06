class Task < ActiveRecord::Base
  attr_accessible :body, :deadline, :occurrence_date, :parent_id, :project_id, :status, :taskable_id, :taskable_type, :title
  acts_as_tree
  belongs_to :project
  default_scope :order => "updated_at ASC"
  has_paper_trail
  has_many :comments, :as => :commentable, :dependent => :destroy
  has_many :notes, :as => :notable, :dependent => :destroy
  has_many :tasks, :as => :taskable, :dependent => :destroy
  validates_presence_of :title
end

# == Schema Information
#
# Table name: tasks
#
#  id              :integer         not null, primary key
#  title           :string(255)
#  body            :text
#  occurrence_date :date
#  taskable_id     :integer
#  taskable_type   :string(255)
#  parent_id       :integer
#  project_id      :integer
#  created_at      :datetime        not null
#  updated_at      :datetime        not null
#  status          :text
#  deadline        :date
#

