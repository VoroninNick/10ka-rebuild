class AddDescriptionToParentCatalog < ActiveRecord::Migration
  def change
    add_column :parent_catalogs, :description, :text
  end
end
