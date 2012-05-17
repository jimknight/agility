class MessagesController < ApplicationController

  def index
  	@project = Project.find(params[:project_id])
    @messages = @project.messages
   end

  def create
  	@project = Project.find(params[:project_id])
    @message = Message.create!(params[:message])
    @project.messages << @message
    current_user.messages << @message
    PrivatePub.publish_to(project_messages_path(@project), message: @message)
  end
end
