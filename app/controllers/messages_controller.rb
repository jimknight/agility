class MessagesController < ApplicationController
  def index
  	@project = Project.find(params[:project_id])
    @messages = @project.messages
   end

  def create
  	@project = Project.find(params[:project_id])
    @message = @project.messages.create!(params[:message])
    PrivatePub.publish_to("/messages/new", message: @message)
  end
end
