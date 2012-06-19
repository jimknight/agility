class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate_user!
  #layout :layout_by_resource

  # rescue_from CanCan::AccessDenied do |exception|
  #   # redirect_to root_url, :alert => exception.message
  #   redirect_to :back, :alert => exception.message
  #  end

  protected

  def layout_by_resource
    if devise_controller?
      "devise"
    else
      "application"
    end
  end
end
