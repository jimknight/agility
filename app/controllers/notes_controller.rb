class NotesController < ApplicationController
  
#  load_and_authorize_resource :note
  require 'nokogiri'
  require 'open-uri'
  def bookmarklet
    @note = Note.new
    if params[:url]
      doc = Nokogiri::HTML(open(params[:url]))
      @title = doc.title
    end
    #   @project.notes.create!(:title => "#{params[:url]}:#{doc.title}", :body => params[:url])
    #@project = Project.find(params[:id])
    # if @project.user_can_read(current_user) == false
    #   redirect_to :root_path
    # else
    #   doc = Nokogiri::HTML(open(params[:url]))
    #   @project.notes.create!(:title => "#{params[:url]}:#{doc.title}", :body => params[:url])
    #   render :text => "New note saved."
    # end
  end
  
  def new
    @parent = find_parent
    @project = Tree.top(@parent)
    @note = @parent.respond_to?(:notes) ? @parent.notes.new : @parent.children.new
  end
  
  def show
    @parent = find_parent
    @note = Note.find(params[:id])
    if @note.user_id && @note.user_id != current_user.id
      redirect_to @parent, :alert => "You are not authorized to view that note."
    else
      @notes = @note.children
    end
  end
  
  def create
    @parent = find_parent
    @note = @parent.respond_to?(:notes) ? @parent.notes.new(params[:note]) : @parent.children.new(params[:note])
    @project = @note.parent_project
    if params[:link].present?
      @note.body = params[:link]
    end
    if params[:audience] == "private"
      @note.user_id = current_user.id
    end
    if @note.save
      if params[:notify_team]
        @note.notify_team # TODO figure out what a failure here should do
      end
      redirect_to @parent, :notice => "Saved new note."
    else
      render 'new'
    end
  end
   
  def edit
    @parent = find_parent
    @note = Note.find(params[:id]) # secure?
    @project = @note.parent_project
  end

  def update
    @parent = find_parent
    @note = Note.find(params[:id])
    @project = @note.parent_project
    @note.update_attributes(params[:note])
    if @note.save
      redirect_to [@parent,@note], :notice => "Your changes were saved."
    else
      render 'edit'
    end
  end

  def destroy
    @parent = find_parent
    @note = Note.find(params[:id])
    @note.destroy
    redirect_to @parent, :notice => "Note was successfully deleted."
  end
  
private

  def find_parent
    if params[:note_id]
      return Note.find(params[:note_id])
    elsif params[:project] # bookmarklet
      return Project.find(params[:project])
    else
      params.each do |name, value|
        if name =~ /(.+)_id$/
          return $1.classify.constantize.find(value)
        end
      end
    end
    @note = Note.find(params[:id])
    @note.notable_type.singularize.classify.constantize.find(@note.notable_id)
  end
  
end
