class Attachment < ActiveRecord::Base
	
  attr_accessible :attachable_id, :attachable_type, :file
  belongs_to :attachable, :polymorphic => true
  mount_uploader :file, AttachmentUploader

  def extension
    file_name.split(".").last
  end
  
  def file_name
    if file.to_s
      File.basename(file.to_s)
    else
      "<no file found>"
    end
  end

end

# == Schema Information
#
# Table name: attachments
#
#  id              :integer         not null, primary key
#  file            :string(255)
#  attachable_id   :integer
#  attachable_type :string(255)
#  created_at      :datetime        not null
#  updated_at      :datetime        not null
#

