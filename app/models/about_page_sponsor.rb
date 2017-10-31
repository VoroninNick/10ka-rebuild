class AboutPageSponsor < ActiveRecord::Base
  attr_accessible :name, :short_description, :url, :about_page, :about_page_id

  belongs_to :about_page

  rails_admin do
  	edit do
  		field :name
  		field :url
  		field :short_description
  		field :about_page
  	end

  	nested do
  		field :name
  		field :url
  		field :short_description
  	end
  end
end
