class AddSlugToParentCatalogs < ActiveRecord::Migration
  def change
    add_column :parent_catalogs, :slug, :string
    add_index :parent_catalogs, :slug
  end
end
