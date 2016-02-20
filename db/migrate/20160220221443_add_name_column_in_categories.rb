class AddNameColumnInCategories < ActiveRecord::Migration
  def change
    add_column :categories, :name, :string
  end
end
