class AboutPageInfo < ActiveRecord::Base
  attr_accessible *attribute_names

  globalize :page_title, :intro, :sales_description, :sponsors_short_description
end
