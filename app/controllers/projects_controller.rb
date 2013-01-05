class ProjectsController < ApplicationController
  
  def show
    if Project.user_can_read(current_user).map(&:id).include?(params[:id].to_i)
      @project = Project.find(params[:id])
      @tasks = @project.tasks
      @open_tasks = @project.tasks.where(:status => "Open")
      @completed_tasks = @project.tasks.where(:status => "Completed")
      @canceled_tasks = @project.tasks.where(:status => "Canceled")      
      @notes = @project.notes
      @inbox_emails = @project.emails.inbox
      @sent_emails = @project.emails.sent
      @attachments = @project.all_project_attachments
    else
      redirect_to projects_path, :alert => "You are not authorized to see that project."
    end
  end
  
  def destroy
    @project = Project.find(params[:id])
    if @project.user_id == current_user.id
      @project.destroy
      redirect_to projects_path, :notice => "Project deleted!"
    else
      redirect_to projects_path, :alert => "You are not authorized to delete that project."
    end
  end
  
  def index
    @projects = Project.user_can_read(current_user)
  end

  def new
    @project = Project.new  
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @project }
    end
  end

  def edit
    @project = Project.find(params[:id])
  end

  def create
    @project = Project.new(params[:project])
    current_user.projects << @project
    respond_to do |format|
      if @project.save
        format.html { redirect_to(@project, :notice => 'Project was successfully created.') }
        format.xml  { render :xml => @project, :status => :created, :location => @project }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @project.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    if Project.user_can_read(current_user).map(&:id).include?(params[:id].to_i)
      @project = Project.find(params[:id])
      respond_to do |format|
        if @project.update_attributes(params[:project])
          format.html { redirect_to(@project, :notice => 'Project was successfully updated.') }
          format.xml  { head :ok }
        else
          format.html { render :action => "edit" }
          format.xml  { render :xml => @project.errors, :status => :unprocessable_entity }
        end
      end
    else
      redirect_to projects_path, :alert => "You are not authorized to update that project."
    end
  end

  # NON-REST ACTIONS

  def user_search
    @project = Project.find(params[:id])
    @user = User.find_by_email(params[:email])
    if @user
      if @project.user_id == @user.id  || @project.users.map(&:id).include?(@user.id)
        redirect_to @project, :alert => "#{@user.email} is already a team member of this project"
      else
        @project.users << @user
        redirect_to @project, :notice => "#{@user.email} added to this project"
      end
    else
      @stub_user = StubUser.find_by_email(params[:email])
      if @stub_user
        redirect_to @project, :alert => "#{@stub_user.email} was already invited to this project. Please ask them to join."
      else
        @project.invite_team_member(current_user,params[:email])
        @project.add_new_team_member_as_stub_user(params[:email])
        redirect_to @project, :alert => "#{params[:email]} couldn't be found so an email was sent inviting them to join. You will be cc'd on the invite."
      end
    end
  end

end
