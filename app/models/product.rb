class Product < ActiveRecord::Base
  attr_accessible *attribute_names

  globalize :name, :url_fragment, :description

  belongs_to :brand
  has_one :subcategory, through: :brand
  has_one :category, through: :subcategory

  scope :order_by_id, -> { order('id desc') }
  default_scope do
    order_by_id
  end

  has_seo_tags
  has_sitemap_record
  has_cache do
    pages self, category, subcategory, brand
  end

  after_create :notify_admin

  image :avatar, styles: { thumb: '180>', prod: '190x190#', main: '420x420#' }

  def url(locale = I18n.locale)
    Cms.url_helpers.send("product_#{locale}_path", id: self.url_fragment)
  end

  def self.custom_move_images
    move_images(':rails_root/public/assets/pr/:id/:style/:basename.:extension')
  end

end
