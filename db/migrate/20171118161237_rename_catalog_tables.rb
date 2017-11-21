class RenameCatalogTables < ActiveRecord::Migration
  def change
    rename_table :new_catalogs, :categories
    rename_table :new_parent_catalogs, :subcategories
    rename_table :new_child_catalogs, :brands
    rename_table :new_products, :products
  end
end
