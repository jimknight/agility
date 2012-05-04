class Email < ActiveRecord::Base
  
  acts_as_tree
  attr_accessible :body, :copy_to, :project_id, :sent_from, :sent_to, :subject
  alias_attribute :title, :subject
  belongs_to :project
  has_many :attachments, :as => :attachable, :dependent => :destroy
  has_many :tasks, :as => :taskable, :dependent => :destroy
  accepts_nested_attributes_for :attachments
  scope :sent, where(:body => "sent")

  def self.send_email(source_email, send_to)
      api_key = ENV["MG_API_KEY"]
      RestClient.post "https://api:key-#{api_key}@api.mailgun.net/v2/agilechamp.mailgun.org/messages",
      :from => "Agile Champ <me@agilechamp.mailgun.org>",
      :to => send_to,
      :subject => "Hello",
      :text => "Testing some Mailgun awesomness!"
  end

end

# == Schema Information
#
# Table name: emails
#
#  id         :integer         not null, primary key
#  subject    :text
#  body       :text
#  sent_from  :text
#  sent_to    :text
#  copy_to    :text
#  project_id :integer
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

