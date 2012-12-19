class AddBodyTextToEmails < ActiveRecord::Migration
  def change
    add_column :emails, :body_text, :text
  end
end
