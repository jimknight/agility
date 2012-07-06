class CreateAccountsProjects < ActiveRecord::Migration
  def change
  	create_table :accounts_projects do |t|
      t.belongs_to :account
      t.belongs_to :project
    end
  end
end
