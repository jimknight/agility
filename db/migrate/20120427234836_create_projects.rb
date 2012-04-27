class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :title
      t.text :body
      t.integer :user_id
      t.string :email

      t.timestamps
    end
  end
end
