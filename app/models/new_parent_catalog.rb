class NewParentCatalog < ActiveRecord::Base
  attr_accessible :description, :name, :new_child_catalog_ids, :new_catalog_id, :slug
	has_many :new_child_catalogs
	belongs_to :new_catalog

  validates :name, presence: true
  validates :slug, uniqueness: true, presence: true

  before_validation :generate_url

  def to_param
	  slug
  end

  def generate_url
	  self.slug ||= name.parameterize
  end

  def url
    Cms.url_helpers.sub_category_path(id: self.slug)
  end
end
