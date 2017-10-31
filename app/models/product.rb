# -*- encoding : utf-8 -*-
class Product < ActiveRecord::Base
  attr_accessible :name,
                  :description,
                  :avatar,
                  :delete_avatar,
                  :parent_catalogs,
                  :parent_catalog_id,
                  :child_catalogs,
                  :child_catalog_id

  # Validate name presence and minimum lenght 2 chars
  validates :name, :presence => true, :length => { :minimum => 2 }
  validates :slug, uniqueness: true, presence: true
  validates :description, :presence => true, :length => { :minimum => 2 }
  validates :child_catalog, :presence => true
  validates :parent_catalog, :presence => true

  # Generate url
  before_validation :generate_slug_for_product

  # remove avatar image
  attr_accessor :delete_avatar
  before_validation { self.avatar.clear if self.delete_avatar == '1' }

  belongs_to :child_catalog
  belongs_to :parent_catalog

  # Paperclip image attachments
  has_attached_file :avatar, :styles => { :thumb => '180>', :prod => '190x190#' },
                    :url  => '/assets/product/:id/:style/:basename.:extension',
                    :path => ':rails_root/public/assets/product/:id/:style/:basename.:extension'


  def to_param
    slug
  end

  def generate_slug_for_product
    self.slug ||= name.parameterize
  end

end
