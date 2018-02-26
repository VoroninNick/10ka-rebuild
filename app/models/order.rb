class Order < ActiveRecord::Base
  attr_accessible *attribute_names

  belongs_to :product

  include Cms::Notifier
end
