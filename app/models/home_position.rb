class HomePosition < ActiveRecord::Base
  attr_accessible :catalog_ids, :name, :catalog_id
  has_many :catalogs
end
