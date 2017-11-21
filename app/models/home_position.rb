class HomePosition < ActiveRecord::Base
  attr_accessible *attribute_names
  has_many :categories
end
