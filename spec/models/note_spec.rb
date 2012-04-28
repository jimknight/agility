require 'spec_helper'

describe Note do
  pending "add some examples to (or delete) #{__FILE__}"
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

