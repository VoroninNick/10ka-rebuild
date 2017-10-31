class AddNewProductIdToNewChildCatalogs < ActiveRecord::Migration
  def change
    add_column :new_child_catalogs, :new_product_id, :integer
  end
end
