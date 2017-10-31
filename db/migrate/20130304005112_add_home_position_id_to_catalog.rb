class AddHomePositionIdToCatalog < ActiveRecord::Migration
  def change
    add_column :catalogs, :home_position_id, :string
    add_index :catalogs, :home_position_id
  end
end
