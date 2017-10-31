class AddSlugToChildCatalogs < ActiveRecord::Migration
  def change
    add_column :child_catalogs, :slug, :string
    add_index :child_catalogs, :slug
  end
end
