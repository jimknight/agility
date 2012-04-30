module ApplicationHelper

    def file_name(file_path)
    File.basename(file_path.to_s)
  end
  
  def pretty_datetime(datetime)
     datetime.strftime('%D %I:%M %P')
  end

end
