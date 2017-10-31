class AddSlugToNewParentCatalog < ActiveRecord::Migration
  def change
    add_column :new_parent_catalogs, :slug, :string
    add_index :new_parent_catalogs, :slug
  end
end
