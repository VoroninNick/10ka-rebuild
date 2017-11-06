class DropAboutPages < ActiveRecord::Migration
  def change
    drop_table :about_pages
  end
end
