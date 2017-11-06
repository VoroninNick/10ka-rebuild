class AddTranslationsToArticles < ActiveRecord::Migration
  def change
    create_translation_table(Article, :name, :url_fragment, :short_description, :content)
  end
end
