class TasksController < ApplicationController
  
  # load_and_authorize_resource :project
  # load_and_authorize_resource :task, :through => :project
  
  def cancel # TODO: secure
    @task = Task.find(params[:id])
    @task.status = "Canceled"
    if @task.save
      redirect_to project_path(@task.project_id), :notice => "Task #{@task.title} canceled"
    end
  end

  def complete # TODO: secure
    @task = Task.find(params[:id])
    @task.status = "Completed"
    if @task.save
      redirect_to project_path(@task.project_id), :notice => "Task #{@task.title} marked completed"
    end
  end

  def new
    @taskable = find_taskable
    @task = @taskable.tasks.new
  end
  
  def create
    @taskable = find_taskable
    @task = @taskable.tasks.build(params[:task])
    @project = Tree.top(@taskable)
    @task.project_id = @project.id
    @task.status = "Open"
    if @task.save
      redirect_to @taskable, :notice => "Successfully created task."
    else
      render :action => 'new'
    end
  end

  def update
    @task = Task.find(params[:id]) # probably insecure. firm up later.
    @project = Project.find(@task.project_id)
    @task.update_attributes(params[:task])
    redirect_to project_path(@project), :notice => 'Task was successfully updated.'
  end
  
  def show
    @parent = find_taskable
    @task = @parent.tasks.find(params[:id])
    @notes = @task.notes
    @project = Project.find(@task.project_id)
  end
  
  def destroy
    @taskable = find_taskable
    @task = @taskable.tasks.find(params[:id])
    @task.destroy
    redirect_to :back, :notice => 'Task was successfully deleted.'
  end

  def edit
    @taskable = find_taskable
    @task = @taskable.tasks.find(params[:id])
  end

private

  def find_taskable
    # I know this is sloppy. Need better solution. First search didn't yield much.
    if params[:id]
      @task = Task.find(params[:id])
      if @task.taskable_id
        return @task.taskable_type.classify.constantize.find(@task.taskable_id)
      elsif @task.project_id
        return Project.find(@task.project_id)
      end
    end
    params.each do |name, value|
      if name =~ /(.+)_id$/
        return $1.classify.constantize.find(value)
      end
    end
    nil
  end

end
