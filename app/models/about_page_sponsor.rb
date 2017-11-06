class AboutPageSponsor < ActiveRecord::Base
  attr_accessible *attribute_names

  globalize :name, :website_url, :short_description

  image :avatar#, styles: {default: "125x125#"}

  boolean_scope :published
  scope :order_by_sorting_position, -> { order("sorting_position asc") }
  default_scope do
    order_by_sorting_position
  end

  has_cache do
    pages :about_us
  end
end
