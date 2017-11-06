class NewProduct < ActiveRecord::Base
  attr_accessible :description, :name, :new_child_catalog_id, :new_child_catalog, :slug, :avatar, :delete_avatar
	#has_one :new_child_catalog
  #accepts_nested_attributes_for :new_child_catalog
  belongs_to :new_child_catalog
  #belongs_to :new_parent_catalog
  #has_and_belongs_to_many :new_child_catalogs


  validates :name, presence: true
  validates :slug, uniqueness: true, presence: true

  before_validation :generate_url

  # remove avatar image
  attr_accessor :delete_avatar
  before_validation { self.avatar.clear if self.delete_avatar == '1' }

  has_attached_file :avatar, :styles => { :thumb => '180>', :prod => '190x190#', :main => '420x420#' },
                    :url  => '/assets/pr/:id/:style/:basename.:extension',
                    :path => ':rails_root/public/assets/pr/:id/:style/:basename.:extension'




  def to_param
	  slug
  end

  def generate_url
	  url = name
	  self.slug ||= url.parameterize
  end

  def url
    Cms.url_helpers.product_path(id: self.slug)
  end

end
