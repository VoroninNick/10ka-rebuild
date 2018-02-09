class Category < ActiveRecord::Base
  attr_accessible *attribute_names

  globalize :name, :url_fragment, :description

	has_many :subcategories
  has_many :brands, through: :subcategories
  has_many :products, through: :brands

  scope :order_by_id, -> { order('id desc') }
  default_scope do
    order_by_id
  end

  has_seo_tags
  has_sitemap_record
  has_cache do
    pages self, subcategories, brands, products
  end

  def url(locale = I18n.locale)
    url_fragment = self.translations_by_locale[locale].try(:url_fragment)
    if url_fragment.blank?
      return nil
    end
    Cms.url_helpers.send("category_#{locale}_path", id: url_fragment)
  end



  def self.find_node_by_url_fragment(url_fragment, locale = I18n.locale)
    models = [Category, Subcategory, Brand, Product]
    node = nil
    models.each do |model|
      if node
        break
      end
      node = model.joins(:translations).where("#{model.translation_class.table_name}": {url_fragment: url_fragment, locale: locale}).first
    end

    node
  end

  def self.node_type(node)
    node.class.name.underscore
  end

  def node_type
    self.class.node_type(self)
  end

  def self.fetch_url_fragments
    models = [Category, Subcategory, Brand, Product]
    url_fragments = models.map{|m| m.all.pluck(:url_fragment) }.flatten
  end

  def self.are_duplicated_url_fragments
    url_fragments = self.fetch_url_fragments
    url_fragments.count != url_fragments.uniq.count
  end
end
