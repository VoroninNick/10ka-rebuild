class CreateHomePageInfos < ActiveRecord::Migration
  def change
    create_table :home_page_infos do |t|
      t.text :about_text

      t.timestamps null: false
    end
  end
end
