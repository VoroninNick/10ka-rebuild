class CreateContactMessageReceivers < ActiveRecord::Migration
  def change
    create_table :contact_message_receivers do |t|
      t.string :email

      t.timestamps
    end
  end
end
