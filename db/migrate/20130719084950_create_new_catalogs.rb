class CreateNewCatalogs < ActiveRecord::Migration
  def change
    create_table :new_catalogs do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
