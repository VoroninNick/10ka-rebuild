class AddSlugToNewChildCatalog < ActiveRecord::Migration
  def change
    add_column :new_child_catalogs, :slug, :string
    add_index :new_child_catalogs, :slug
  end
end
