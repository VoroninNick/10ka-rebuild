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
end
