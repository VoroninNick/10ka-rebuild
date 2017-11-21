# -*- encoding : utf-8 -*-
class Sponsor < ActiveRecord::Base
  attr_accessible *attribute_names

  # Validate name presence and minimum lenght 2 chars
  validates :name, :presence => true, :length => { :minimum => 2 }
  validates :description, :presence => true, :length => { :minimum => 10 }

  # Paperclip image attachments
  image :sponsor, :styles => { :thumb => '150x150>' }

  def self.custom_move_images
    move_images(':rails_root/public/assets/sponsor/:id/:style/:basename.:extension')
  end

end
