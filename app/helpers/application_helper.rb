module ApplicationHelper

    def file_name(file_path)
    File.basename(file_path.to_s)
  end
  
  def pretty_datetime(datetime)
     datetime.strftime('%D %I:%M %P')
  end

  def timeline_entry(version)
  	updated_model = version.item_type.constantize.find(version.item_id)
  	version_user = User.find(version.whodunnit.to_i) if version.whodunnit
  	if version.item_type == "Email"
  			if version.event == "create"
		  		project = Project.find(updated_model.project_id)
		  		result = "An "
		  		result += link_to "email", updated_model
		  		result += " (#{updated_model.subject}) was received from #{updated_model.sent_from} for the "
		  		result += link_to project.title, project
		  		result += " project."
		  		return result.html_safe
		  	end
  	else
  		result = link_to version_user.full_name, "#"
			result += " #{version.event}d the "
			result += link_to updated_model.title, updated_model
			result += " #{version.item_type.downcase}."
			return result
		end
  end

end
