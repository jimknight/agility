class AddEmailTypeToEmails < ActiveRecord::Migration
  def change
    add_column :emails, :email_type, :string
  end
end
