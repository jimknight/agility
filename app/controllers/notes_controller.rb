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
    @note = @parent.respond_to?(:notes) ? @parent.notes.new : @parent.children.new
  end
  
  def show
    @parent = find_parent
    @note = Note.find(params[:id])
  end
  
  def create
    @parent = find_parent
    @note = @parent.respond_to?(:notes) ? @parent.notes.new(params[:note]) : @parent.children.new(params[:note])
    if params[:link].present?
      @note.body = params[:link]
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
    @note = @parent.find(params[:id])
  end

  def update
    @parent = find_parent
    @note = @parent.find(params[:id])
    @note.update_attributes(params[:note])
    if @note.save
      redirect_to [@parent,@note], :notice => "Your changes were saved."
    else
      render 'edit'
    end
  end

  def destroy
    @parent = find_parent
    @note = @parent.find(params[:id])
    @note.destroy
    redirect_to root_path, :notice => "Note was successfully deleted. Redirect to parent."
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
    nil
  end
  
end
