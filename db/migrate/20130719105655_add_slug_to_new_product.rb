class AddSlugToNewProduct < ActiveRecord::Migration
  def change
    add_column :new_products, :slug, :string
    add_index :new_products, :slug
  end
end
