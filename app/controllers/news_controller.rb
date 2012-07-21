class NewsController < ApplicationController

  def timeline
  	projects_user_can_read = Project.user_can_read(current_user)
    emails_user_can_read = projects_user_can_read.map(&:email_ids).flatten
  	tasks_user_can_read = projects_user_can_read.map(&:task_ids).flatten
  	notes_user_can_read = projects_user_can_read.map(&:note_ids).flatten
  	@news_items = Version
			.where{
				(item_type == "Project") & (item_id >> projects_user_can_read.map(&:id)) |
        (item_type == "Email") & (item_id >> emails_user_can_read) | 
				(item_type == "Task") & (item_id >> tasks_user_can_read) | 
				(item_type == "Note") & (item_id >> notes_user_can_read)
			}
    end
end
