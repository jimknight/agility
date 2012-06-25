class Email < ActiveRecord::Base
  
  acts_as_tree
  attr_accessible :body, :copy_to, :project_id, :sent_from, :sent_to, :subject
  alias_attribute :title, :subject
  belongs_to :project
  has_many :attachments, :as => :attachable, :dependent => :destroy
  has_many :notes, :as => :notable, :dependent => :destroy
  has_many :tasks, :as => :taskable, :dependent => :destroy
  accepts_nested_attributes_for :attachments
  scope :sent, where(:body => "sent")

  def send_email
      @project = Project.find(project_id)
      cc = @project.project_copy_to(id)
      copy_to = copy_to.blank? ? cc : copy_to + ", " + cc
      api_key = ENV["MG_API_KEY"]
      RestClient.post "https://api:key-#{api_key}@api.mailgun.net/v2/agilechamp.mailgun.org/messages",
      :from => "Agile Champ <me@agilechamp.mailgun.org>",
      :to => sent_to,
      :copy_to => copy_to,
      :subject => subject,
      :html => body
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
#

