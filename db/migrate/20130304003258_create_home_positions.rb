class CreateHomePositions < ActiveRecord::Migration
  def change
    create_table :home_positions do |t|
      t.string :name
      t.integer :catalog_id

      t.timestamps
    end
  end
end
