class Email < ActiveRecord::Base
  
  acts_as_tree
  default_scope :order => "created_at DESC"
  has_paper_trail
  attr_accessible :body, :copy_to, :project_id, :sent_from, :sent_to, :subject, :email_type
  alias_attribute :title, :subject
  belongs_to :project
  has_many :attachments, :as => :attachable, :dependent => :destroy
  has_many :comments, :as => :commentable, :dependent => :destroy
  has_many :notes, :as => :notable, :dependent => :destroy
  has_many :tasks, :as => :taskable, :dependent => :destroy
  accepts_nested_attributes_for :attachments
  scope :sent, where(:email_type => "sent")
  scope :inbox, :conditions => ['email_type != ?', "sent"]

  def send_email
    # TODO: Figure out how to pass a parameter if it exists. e.g. copy_to if present?
    @project = Project.find(project_id)
    cc = @project.project_copy_to(id)
    copy_to = copy_to.blank? ? cc : copy_to + ", " + cc
    api_key = ENV["MG_API_KEY"]
    if copy_to.present?
      RestClient.post "https://api:key-#{api_key}@api.mailgun.net/v2/agilechamp.mailgun.org/messages",
        :from => @project.email,
        :to => sent_to,
        :cc => copy_to,
        :subject => subject,
        :html => body
    else
      RestClient.post "https://api:key-#{api_key}@api.mailgun.net/v2/agilechamp.mailgun.org/messages",
        :from => @project.email,
        :to => sent_to,
        :subject => subject,
        :html => body
    end
  end

end



# == Schema Information
#
# Table name: emails
#
#  id             :integer         not null, primary key
#  subject        :text
#  body           :text
#  sent_from      :text
#  sent_to        :text
#  copy_to        :text
#  project_id     :integer
#  created_at     :datetime        not null
#  updated_at     :datetime        not null
#  parent_id      :integer
#  emailable_id   :integer
#  emailable_type :string(255)
#  email_type     :string(255)
#  body_text      :text
#

