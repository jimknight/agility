class Email < ActiveRecord::Base
  attr_accessible :body, :copy_to, :project_id, :sent_from, :sent_to, :subject
end
