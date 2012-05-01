class EmailsController < ApplicationController

  skip_before_filter :verify_authenticity_token
  skip_before_filter :authenticate_user! # todo - setup something for mailgun

  def create
    @email = Email.new
    @email.subject = params[:subject]
    @email.body = params["body-html"]
    @email.sent_from = params[:from]
    @email.save
    if params[:recipient]
      @project = Project.find_by_email(params[:recipient].downcase)
      @project.emails << @email if @project # have to decide what to do with incoming email with no match
    end
    count = params["attachment-count"].to_i
    count.times do |i|
      stream = params["attachment-#{i+1}"]
      filename = stream.original_filename
      data = stream.read() # got from heroku. maybe time delay in this case
      @attachment = @email.attachments.build(:file => params["attachment-#{i+1}"])
      @attachment.save
    end
    render :text => 'success', :status => 200 # a status of 404 would reject the mail
  end
  
  def index
    @emails = Email.all
  end
  
  def show
    @email = Email.find(params[:id])
    @project = Project.find(@email.project_id)
    @attachments = @email.attachments
  end
  
  def new
    @email = Email.new
    @email.attachments.build
  end
  
  def destroy
    @project = Project.find(params[:project_id])
    @email = @project.emails.find(params[:id])
    @email.destroy
    redirect_to @project, :notice => "You successfully deleted the '#{@email.subject}' email."
  end

end