class CreateAboutPageInfos < ActiveRecord::Migration
  def change
    create_table :about_page_infos do |t|
      t.string :page_title
      t.text :intro
      t.text :sales_description
      t.text :sponsors_short_description

      t.timestamps null: false
    end

    create_translation_table(AboutPageInfo, :intro, :sales_description, :sponsors_short_description)
  end
end
