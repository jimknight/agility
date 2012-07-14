class Comment < ActiveRecord::Base

  attr_accessible :body, :commentable_type, :user_id, :commentable_id

end

# == Schema Information
#
# Table name: comments
#
#  id               :integer         not null, primary key
#  body             :text
#  user_id          :integer
#  commentable_id   :integer
#  commentable_type :string(255)
#  created_at       :datetime        not null
#  updated_at       :datetime        not null
#

