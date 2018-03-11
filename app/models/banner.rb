# -*- encoding : utf-8 -*-
class Banner < ActiveRecord::Base
  attr_accessible *attribute_names

  # Validate name presence and minimum lenght 2 chars
  validates :name, :presence => true, :length => { :minimum => 2 }

  # Paperclip image attachments
  image :banner, :styles => { :thumb => '150x150>', :main => '1200x400#' }

  def self.custom_move_images
    move_images(':rails_root/public/assets/banner/:id/:style/:basename.:extension')
  end

  has_cache do
    pages :home
  end

end
