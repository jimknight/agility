module ApplicationHelper

	def tier_description(tier)
		return "10 Projects (3 GB)" if tier == "1"
		return "25 Projects (10 GB)" if tier == "2"
		return "50 Projects (50 GB)" if tier == "3"
	end

  def tier_pricing(tier)
    return "$20/month" if tier == "1"
    return "$50/month" if tier == "2"
    return "$100/month" if tier == "3"
  end

  def file_name(file_path)
    File.basename(file_path.to_s)
  end
  
  def pretty_datetime(datetime)
     datetime.strftime('%D %I:%M %P')
  end

end
