class AddAvatarToNewProducts < ActiveRecord::Migration
  def change
    add_column :new_products, :avatar_file_name, :string
    add_column :new_products, :avatar_content_type, :string
    add_column :new_products, :avatar_file_size, :integer
    add_column :new_products, :avatar_updated_at, :datetime
  end
end
