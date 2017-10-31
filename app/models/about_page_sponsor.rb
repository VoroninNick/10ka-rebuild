class AboutPageSponsor < ActiveRecord::Base
  attr_accessible :name, :short_description, :url, :about_page, :about_page_id

  belongs_to :about_page
end
