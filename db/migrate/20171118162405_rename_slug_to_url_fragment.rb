class RenameSlugToUrlFragment < ActiveRecord::Migration
  def change
    tables = ["brands", "categories", "products", "subcategories"]
    tables.each do |t|
      rename_column t, :slug, :url_fragment
    end
  end
end
