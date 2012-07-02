class CreateStubUsers < ActiveRecord::Migration
  def change
    create_table :stub_users do |t|
      t.string :email
      t.integer :project_id

      t.timestamps
    end
  end
end
