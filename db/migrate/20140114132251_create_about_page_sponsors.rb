class CreateAboutPageSponsors < ActiveRecord::Migration
  def change
    create_table :about_page_sponsors do |t|
      t.string :name
      t.string :url
      t.text :short_description
      t.belongs_to :about_page

      t.timestamps
    end
  end
end
