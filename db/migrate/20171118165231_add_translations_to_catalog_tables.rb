class AddTranslationsToCatalogTables < ActiveRecord::Migration
  def change
    create_translation_table(Category, :name, :url_fragment, :description)
    create_translation_table(Subcategory, :name, :url_fragment, :description)
    create_translation_table(Brand, :name, :url_fragment, :description)
    create_translation_table(Product, :name, :url_fragment, :description)
  end
end
