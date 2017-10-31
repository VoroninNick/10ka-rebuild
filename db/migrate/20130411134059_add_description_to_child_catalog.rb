class AddDescriptionToChildCatalog < ActiveRecord::Migration
  def change
    add_column :child_catalogs, :description, :text
    add_column :child_catalogs, :avatar_file_name, :string
    add_column :child_catalogs, :avatar_content_type, :string
    add_column :child_catalogs, :avatar_file_size, :integer
    add_column :child_catalogs, :avatar_updated_at, :datetime
  end
end
