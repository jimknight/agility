
class CommentsController < ApplicationController

	def create
		@comment = Comment.new(params[:comment])
		@comment.user_id = current_user.id
		if @comment.save
			redirect_to :back, :notice => "Comment added"
		else
			redirect_to :back, :alert => "Problem saving comment"
		end
	end

end
