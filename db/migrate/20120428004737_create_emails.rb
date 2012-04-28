class CreateEmails < ActiveRecord::Migration
  def change
    create_table :emails do |t|
      t.text :subject
      t.text :body
      t.text :sent_from
      t.text :sent_to
      t.text :copy_to
      t.integer :project_id

      t.timestamps
    end
  end
end
