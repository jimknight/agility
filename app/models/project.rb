class Project < ActiveRecord::Base

  attr_accessible :body, :email, :title
  belongs_to :user
  default_scope :order => "title ASC"
  has_paper_trail
  has_many :comments, :as => :commentable, :dependent => :destroy
  has_many :emails, :dependent => :destroy
  has_many :memberships
  has_many :messages, :dependent => :destroy
  has_many :notes, :as => :notable, :dependent => :destroy
  has_many :tasks, :dependent => :destroy
  has_many :users, :through => :memberships
  has_and_belongs_to_many :stub_users
  validates_presence_of :title, :email
  validates_uniqueness_of :email, :case_sensitive => false

  def self.user_can_read(user)
    Project.joins(:users).where(:users => {:id => user.id}) | Project.where(:user_id => user.id)
  end

  def add_new_team_member_as_stub_user(invitee_email)
    @stub_user = StubUser.create!(:email => invitee_email)
    self.stub_users << @stub_user
  end

  def all_project_attachments
    email_attachments = []
    self.emails.each do |email|
      email.attachments.each do |attachment|
        email_attachments << attachment
      end
    end
    return email_attachments
  end

  def captain?(user)
    self.user_id == user.id
  end
  
  def invite_team_member(inviter,invitee_email)
    api_key = ENV["MG_API_KEY"]
    RestClient.post "https://api:key-#{api_key}@api.mailgun.net/v2/agilechamp.mailgun.org/messages",
    :from => email,
    :to => invitee_email,
    :cc => inviter.email,
    :subject => "Invitation to join a project",
    :html => "#{inviter.full_name} has invited you to join the '#{title}' project. Go to <a href='http://agilechamp.com/users/sign_up?email=#{invitee_email}'>AgileChamp.com</a>, enter your email as #{invitee_email}, enter a new password, and you will be a part of the project."
  end

  def project_copy_to(email_id)
  	# e.g. project-email.id@agilechamp.com
  	"#{email.split("@")[0]}-#{email_id}@#{email.split("@")[1]}"
  end

  def user_can_read(user)
    return true if self.user_id == user.id
    return true if self.users.map(&:id).include?(user.id)
    false
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

