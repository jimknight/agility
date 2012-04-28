class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.string :title
      t.text :body
      t.integer :notable_id
      t.string :notable_type
      t.integer :parent_id

      t.timestamps
    end
  end
end
