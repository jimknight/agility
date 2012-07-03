class RegistrationsController < Devise::RegistrationsController
  def new
    super
  end

  def create
  	super
  	# find all the projects with this stub user and change them to real users
  	StubUser.find_all_by_email(params[:user][:email]).each do |stub_user|
  		stub_user.projects.each do |project|
        user = User.find_by_email(params[:user][:email])
    		project.users << user
    		stub_user.destroy
      end
  	end
  end

  def update
    super
  end
end 