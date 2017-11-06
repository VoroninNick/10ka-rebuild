class ContactRequest < ActiveRecord::Base
  attr_accessible *attribute_names

  include Cms::Notifier

  validates_presence_of :name, :phone, :email

  extend Cms::FormAttributesHelper

  def self.fields_from_model
    self.form_attributes(true)
  end
end
