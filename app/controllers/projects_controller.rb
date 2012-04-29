class ProjectsController < ApplicationController  
  
  #load_and_authorize_resource :through => :current_user
  
  def show
    # empty because work done by load_and_authorize_resource
    @project = Project.find(params[:id]) # remove this when load/auth re-enabled
    @tasks = @project.tasks
    @notes = @project.notes
    @emails = @project.emails
  end
  
  def destroy
    @project = Project.find(params[:id])
    @project.destroy
    redirect_to projects_path, :notice => "Project deleted!"
  end
  
  def index
     # empty because work done by load_and_authorize_resource
     @projects = Project.all # just for testing for now
  end

  # GET /projects/new
  # GET /projects/new.xml
  def new
    @project = Project.new
  
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @project }
    end
  end

  # GET /projects/1/edit
  def edit
    @project = Project.find(params[:id])
  end

  # POST /projects
  # POST /projects.xml
  def create
    @project = Project.new(params[:project])
    #current_user.projects << @project reenable when done

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

  # PUT /projects/1
  # PUT /projects/1.xml
  def update
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
  end


end
