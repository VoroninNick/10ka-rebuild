class AddSlugToNewCatalog < ActiveRecord::Migration
  def change
    add_column :new_catalogs, :slug, :string
    add_index :new_catalogs, :slug
  end
end
