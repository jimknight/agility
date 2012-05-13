class Project < ActiveRecord::Base

  attr_accessible :body, :email, :title
  belongs_to :user
  has_many :emails
  has_many :notes, :as => :notable, :dependent => :destroy
  has_many :tasks, :dependent => :destroy
  validates_presence_of :title, :email
  validates_uniqueness_of :email, :case_sensitive => false
  
  def project_copy_to(email_id)
  	# e.g. project-email.id@agilechamp.com
  	"#{email.split("@")[0]}-#{email_id}@#{email.split("@")[1]}"
  end

end

# == Schema Information
#
# Table name: projects
#
#  id         :integer         not null, primary key
#  title      :string(255)
#  body       :text
#  user_id    :integer
#  email      :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

