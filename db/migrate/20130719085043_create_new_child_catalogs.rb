class CreateNewChildCatalogs < ActiveRecord::Migration
  def change
    create_table :new_child_catalogs do |t|
      t.string :name
      t.text :description
      t.integer :new_parent_catalog_id

      t.timestamps
    end
  end
end
