class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :name
      t.string :phone
      t.string :email
      t.text :comment

      t.string :referer
      t.string :session_id

      t.timestamps null: false
    end
  end
end
