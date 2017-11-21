class RenameCatalogAssociationColumns < ActiveRecord::Migration
  def change
    rename_column :subcategories, :new_catalog_id, :category_id
    rename_column :brands, :new_parent_catalog_id, :subcategory_id
    rename_column :products, :new_child_catalog_id, :brand_id
  end
end
