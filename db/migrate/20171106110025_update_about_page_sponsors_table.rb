class UpdateAboutPageSponsorsTable < ActiveRecord::Migration
  def change
    remove_column :about_page_sponsors, :about_page_id, :integer
    add_column :about_page_sponsors, :website_url, :string
    add_column :about_page_sponsors, :published, :boolean
    add_column :about_page_sponsors, :sorting_position, :integer
    change_table :about_page_sponsors do |t|
      t.image :avatar
    end
  end
end
