class AddSalesImageToAboutPageInfo < ActiveRecord::Migration
  def change
    change_table :about_page_infos do |t|
      t.image :sales_image
    end
  end
end
