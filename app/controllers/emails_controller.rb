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
    when "new", "reply", "reply_to_all", "forward"
      if type == "new"
        email_type = "sent"
      elsif type == "reply_to_all"
        email_type = "reply to all"
      else
        email_type = type
      end
      @email = Email.new(
        :subject => params[:email][:subject],
        :body => params[:email][:body],
        :sent_to => params[:email][:sent_to],
        :copy_to => params[:email][:copy_to],
        :email_type => email_type
      )
      if @email.save!        
        if type == "new"
          @project = Project.find(params[:project_id])
          @project.emails << @email
          @email.send_email # TODO check for actually sent
          redirect_to @project, :notice => "Message sent"
        else
          @parent_email = Email.find(params[:email_id])
          @project = Project.find(@parent_email.project_id)
          @project.emails << @email          
          @parent_email.children << @email
          @email.send_email # TODO check for actually sent
          redirect_to @parent_email, :notice => "Message sent"
        end        
      else
        render "new"
      end
    end
  end

  def posted_from_mailgun
    # TODO extract all this complexity out
    @email = Email.new
    @email.subject = params[:subject]
    @email.body = params["body-html"] # record text version as well
    @email.body_text = params["body-plain"]
    @email.sent_from = params[:from]
    @email.sent_to = params[:To]
    @email.copy_to = params[:Cc] if params[:Cc]
    @email.email_type = "received"
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
    @notes = @email.notes
    @tasks = @email.tasks
    if params[:project_id]
      @project = Project.find(params[:project_id])
    else
      @project = Project.find(@email.project_id)
    end if
    @attachments = @email.attachments
  end
  
  def new
    # parent can either be a project or an email
    if params[:email_id]
      @parent = Email.find(params[:email_id])
    else
      @parent = Project.find(params[:project_id])
    end
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
