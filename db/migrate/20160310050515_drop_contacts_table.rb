class DropContactsTable < ActiveRecord::Migration
  def change
    drop_table :first_names
  end
end
