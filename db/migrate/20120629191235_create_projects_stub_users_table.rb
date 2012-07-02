class CreateProjectsStubUsersTable < ActiveRecord::Migration
  def change
  	create_table :projects_stub_users do |t|
      t.belongs_to :project
      t.belongs_to :stub_user      
    end
  end
end
