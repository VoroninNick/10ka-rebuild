class UpdateArticlesTable < ActiveRecord::Migration
  def change
    add_column :articles, :published, :boolean
    rename_column :articles, :description, :content
    rename_column :articles, :slug, :url_fragment
    add_column :articles, :release_date, :date
  end
end
