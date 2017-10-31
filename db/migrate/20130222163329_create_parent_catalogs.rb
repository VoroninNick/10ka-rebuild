# -*- encoding : utf-8 -*-
class CreateParentCatalogs < ActiveRecord::Migration
  def change
    create_table :parent_catalogs do |t|
      t.string :name
      t.integer :catalog_id

      t.timestamps
    end
  end
end
