class CreateNewProducts < ActiveRecord::Migration
  def change
    create_table :new_products do |t|
      t.string :name
      t.text :description
      t.integer :new_child_catalog_id

      t.timestamps
    end
  end
end
