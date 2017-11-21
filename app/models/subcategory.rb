class Subcategory < ActiveRecord::Base
  attr_accessible *attribute_names

  globalize :name, :url_fragment, :description

	has_many :brands
	belongs_to :category
  has_many :products, through: :brands

  scope :order_by_id, -> { order('id desc') }
  default_scope do
    order_by_id
  end

  has_seo_tags
  has_sitemap_record
  has_cache do
    pages self, category, brands, products
  end

  def url(locale = I18n.locale)
    Cms.url_helpers.send("subcategory_#{locale}_path", id: self.url_fragment)
  end
end
