class NewChildCatalog < ActiveRecord::Base
  attr_accessible :description, :name, :new_parent_catalog_id, :slug
	has_many :new_products
	belongs_to :new_parent_catalog

  validates :name, presence: true
  validates :slug, uniqueness: true, presence: true

  before_validation :generate_url

  def to_param
	  slug
  end

  def generate_url
		url = name + '-' + new_parent_catalog.name
	  self.slug ||= url.parameterize
  end

  def self.fullname
		"#{self.new_parent_catalog.name} #{self.name}"
  end

  #def self.name
	 # parent_catalog = NewCatalog.find(self.new_parent_catalog).first
	 # self.new_catalog.name = "#{parent_catalog.name self.name}"
  #end

  def url
    Cms.url_helpers.sub_sub_category_path(id: self.slug)
  end

end
