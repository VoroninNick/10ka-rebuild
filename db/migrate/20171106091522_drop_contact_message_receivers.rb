class DropContactMessageReceivers < ActiveRecord::Migration
  def change
    drop_table :contact_message_receivers
  end
end
