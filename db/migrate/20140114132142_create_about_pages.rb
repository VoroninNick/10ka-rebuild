class CreateAboutPages < ActiveRecord::Migration
  def change
    create_table :about_pages do |t|
      t.text :top_description
      t.text :bottom_description

      t.timestamps
    end
  end
end
