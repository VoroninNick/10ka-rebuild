class AddFeaturedToArticle < ActiveRecord::Migration
  def change
    add_column :articles, :featured, :boolean
  end
end
