# -*- encoding : utf-8 -*-
class CreateChildCatalogs < ActiveRecord::Migration
  def change
    create_table :child_catalogs do |t|
      t.string :name
      t.integer :parent_catalog_id

      t.timestamps
    end
  end
end
