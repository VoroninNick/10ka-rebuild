class AboutPage < ActiveRecord::Base
  attr_accessible :bottom_description, :top_description, :about_page_sponsors, :about_page_sponsor_ids, :about_page_sponsors_attributes

  has_many :about_page_sponsors, :dependent => :destroy
  accepts_nested_attributes_for :about_page_sponsors, :allow_destroy => true

end
