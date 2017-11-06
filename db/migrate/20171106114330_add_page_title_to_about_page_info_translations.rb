class AddPageTitleToAboutPageInfoTranslations < ActiveRecord::Migration
  def change
    add_column :about_page_info_translations, :page_title, :string
  end
end
