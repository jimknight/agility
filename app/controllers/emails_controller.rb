class EmailsController < ApplicationController

  skip_before_filter :verify_authenticity_token
  skip_before_filter :authenticate_user! # todo - setup something for mailgun

  def create
    if params["body-html"]
      posted_from_mailgun
    else
      posted_from_internal(params["email"]["type"])
    end
  end

  def posted_from_internal(type)
    case type
    when "reply", "reply_to_all", "forward"
      @parent_email = Email.find(params[:email_id])
      @email = Email.new(
        :subject => params[:email][:subject],
        :body => params[:email][:body],
        :sent_to => params[:email][:sent_to],
        :copy_to => params[:email][:copy_to]
      )
      if @email.save!
        @parent_email.children << @email
        @email.send_email # TODO check for actually sent
        redirect_to @parent_email, :notice => "Message sent"
      else
        render "new"
      end
    end
  end

  def posted_from_mailgun
    # TODO extract all this complexity out
    @email = Email.new
    @email.subject = params[:subject]
    @email.body = params["body-html"]
    @email.sent_from = params[:from]
    @email.save
    if params[:recipient]
      if params[:recipient].include?("-")
        parse1 = params[:recipient].split("@")
        parse2 = parse1[0].split("-")
        @project = Project.find_by_email((parse2[0] + "@" + parse1[1]).downcase)
        @project.emails << @email if @project # have to decide what to do with incoming email with no match
        @parent_email = Email.find(parse2[1].to_i)
        @parent_email.children << @email
      else
        @project = Project.find_by_email(params[:recipient].downcase)
        @project.emails << @email if @project # have to decide what to do with incoming email with no match
      end
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
    @parent = Email.find(params[:email_id])
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
