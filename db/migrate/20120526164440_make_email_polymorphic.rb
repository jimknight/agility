class MakeEmailPolymorphic < ActiveRecord::Migration
  def change
    add_column :emails, :emailable_id, :integer
    add_column :emails, :emailable_type, :string
  end
end
