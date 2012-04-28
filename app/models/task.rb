class Task < ActiveRecord::Base
  attr_accessible :body, :occurrence_date, :parent_id, :project_id, :taskable_id, :taskable_type, :title
  acts_as_tree
  belongs_to :project
  has_many :notes, :as => :notable, :dependent => :destroy
  has_many :tasks, :as => :taskable, :dependent => :destroy
end
