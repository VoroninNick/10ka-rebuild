# -*- encoding : utf-8 -*-
class CreateSponsors < ActiveRecord::Migration
  def change
    create_table :sponsors do |t|
      t.string :name
      t.string :link
      t.string :description
      t.string :sponsor_file_name
      t.string :sponsor_content_type
      t.integer :sponsor_file_size
      t.datetime :sponsor_updated_at

      t.timestamps
    end
  end
end
