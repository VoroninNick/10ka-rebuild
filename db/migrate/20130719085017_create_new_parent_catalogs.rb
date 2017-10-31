class CreateNewParentCatalogs < ActiveRecord::Migration
  def change
    create_table :new_parent_catalogs do |t|
      t.string :name
      t.text :description
      t.integer :new_catalog_id

      t.timestamps
    end
  end
end
