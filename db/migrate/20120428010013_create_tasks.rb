class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :title
      t.text :body
      t.date :occurrence_date
      t.integer :taskable_id
      t.string :taskable_type
      t.integer :parent_id
      t.integer :project_id

      t.timestamps
    end
  end
end
