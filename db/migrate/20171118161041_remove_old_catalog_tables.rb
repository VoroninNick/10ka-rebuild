class RemoveOldCatalogTables < ActiveRecord::Migration
  def change
    drop_table :catalogs
    drop_table :child_catalogs
    drop_table :parent_catalogs
    drop_table :products
  end
end
