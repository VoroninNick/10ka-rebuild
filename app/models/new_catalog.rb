class NewCatalog < ActiveRecord::Base
  attr_accessible :description, :name, :slug, :new_parent_catalog_ids
	has_many :new_parent_catalogs

  validates :name, presence: true
  validates :slug, uniqueness: true, presence: true

  before_validation :generate_url

  def to_param
	  slug
  end

  def generate_url
	  self.slug ||= name.parameterize
  end

  def self.find_node_by_url_fragment(url_fragment)
    models = [NewCatalog, NewParentCatalog, NewChildCatalog, NewProduct]
    node = nil
    models.each do |model|
      if node
        break
      end
      node = model.where(slug: url_fragment).first
    end

    node
  end

  def self.node_type(node)
    if node.is_a?(NewCatalog)
      "category"
    elsif node.is_a?(NewParentCatalog)
      "sub_category"
    elsif node.is_a?(NewChildCatalog)
      "sub_sub_category"
    elsif node.is_a?(NewProduct)
      "product"
    end
  end

  def self.fetch_url_fragments
    models = [NewCatalog, NewParentCatalog, NewChildCatalog, NewProduct]
    url_fragments = models.map{|m| m.all.pluck(:slug) }.flatten
  end

  def self.are_duplicated_url_fragments
    url_fragments = self.fetch_url_fragments
    url_fragments.count != url_fragments.uniq.count
  end

  def url
    Cms.url_helpers.category_path(id: self.slug)
  end

  def sub_categories
    new_parent_catalogs
  end
end
