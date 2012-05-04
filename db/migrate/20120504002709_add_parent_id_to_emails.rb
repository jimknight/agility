class AddParentIdToEmails < ActiveRecord::Migration
  def change
    add_column :emails, :parent_id, :integer
  end
end
