# -*- encoding : utf-8 -*-
class ParentCatalog < ActiveRecord::Base
  attr_accessible :catalog_id, :name, :description, :slug

  validates :name, presence: true
  validates :slug, uniqueness: true, presence: true

  before_validation :generate_slug_for_p_catalog

  has_many :child_catalogs #, :through => :products
  belongs_to :catalog

  def to_param
    slug
  end

  def generate_slug_for_p_catalog
    self.slug ||= name.parameterize
  end
end
