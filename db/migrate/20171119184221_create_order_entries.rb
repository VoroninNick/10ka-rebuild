class CreateOrderEntries < ActiveRecord::Migration
  def change
    create_table :order_entries do |t|
      t.integer :order_id
      t.integer :product_id
      t.integer :products_count

      t.timestamps null: false
    end
  end
end
