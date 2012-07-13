class NewsController < ApplicationController

  def timeline
  	@news_items = Version.where(:event => "create").order("created_at DESC").last(30)
  end

end
