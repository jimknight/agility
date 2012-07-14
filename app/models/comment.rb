class Comment < ActiveRecord::Base

  attr_accessible :body, :commentable_type, :user_id, :commentable_id

end
