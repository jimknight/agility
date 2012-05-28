class Note < ActiveRecord::Base

	attr_accessible :title, :body
	acts_as_tree
  belongs_to :attachable, :polymorphic => true
  belongs_to :project
  has_many :attachments, :as => :attachable, :dependent => :destroy
  has_many :emails, :as => :emailable, :dependent => :destroy
  has_many :tasks, :as => :taskable, :dependent => :destroy
  accepts_nested_attributes_for :attachments

  def notify_team
    @project = Project.find(self.notable_id)
    send_to_list = ""
    @project.users.each do |user|
      send_to_list << user.email
    end
    @email = @project.emails.create!(
      :subject => self.title,
      :body => self.body,
      :sent_to => send_to_list
    )
    @email.copy_to = @project.project_copy_to(@email.id)
    @email.save
    @email.send_email
  end

end

# == Schema Information
#
# Table name: notes
#
#  id           :integer         not null, primary key
#  title        :string(255)
#  body         :text
#  notable_id   :integer
#  notable_type :string(255)
#  parent_id    :integer
#  created_at   :datetime        not null
#  updated_at   :datetime        not null
#

