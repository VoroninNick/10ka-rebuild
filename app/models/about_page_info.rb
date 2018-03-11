class AboutPageInfo < ActiveRecord::Base
  attr_accessible *attribute_names

  globalize :page_title, :intro, :sales_description, :sponsors_short_description

  image :sales_image

  has_cache do
    pages :about_us
  end
end
