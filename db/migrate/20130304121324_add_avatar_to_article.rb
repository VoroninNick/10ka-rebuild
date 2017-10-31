class AddAvatarToArticle < ActiveRecord::Migration
  def change
    add_column :articles, :avatar_file_name, :string
    add_column :articles, :avatar_content_type, :string
    add_column :articles, :avatar_file_size, :integer
    add_column :articles, :avatar_updated_at, :datetime
  end
end
