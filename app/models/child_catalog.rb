# -*- encoding : utf-8 -*-
class ChildCatalog < ActiveRecord::Base
  attr_accessible :name, :parent_catalog_id, :slug, :description, :avatar, :delete_avatar

  attr_accessor :delete_avatar
  before_validation { self.avatar.clear if self.delete_avatar == '1' }

  validates :name, presence: true
  validates :slug, uniqueness: true, presence: true

  before_validation :generate_slug_for_c_catalog

  belongs_to :parent_catalog
  has_many :products #, :through => :parent_catalog

  has_attached_file :avatar, :styles => { :tab => '70x70>', :admin_prv => '50x50>' },
                    :url  => '/assets/child-catalog/:id/:style/:basename.:extension',
                    :path => ':rails_root/public/assets/child-catalog/:id/:style/:basename.:extension'




  def to_param
    slug
  end

  def generate_slug_for_c_catalog
    name_slugged = name + parent_catalog.slug
    self.slug ||= name_slugged.parameterize
  end

  def self.fullname
	  self.parent_catalog.catalog.name + self.parent_catalog.name + self.name
  end

  def self.value
	  self.parent_catalog.catalog.name + self.parent_catalog.name + self.name
  end

  def self.title
	  self.parent_catalog.catalog.name + self.parent_catalog.name + self.name
  end
end
