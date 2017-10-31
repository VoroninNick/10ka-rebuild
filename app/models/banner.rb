# -*- encoding : utf-8 -*-
class Banner < ActiveRecord::Base
  attr_accessible :banner, :description, :name, :delete_banner, :url

  attr_accessor :delete_banner
  before_validation { self.banner.clear if self.delete_banner == '1' }

  # Validate name presence and minimum lenght 2 chars
  validates :name, :presence => true, :length => { :minimum => 2 }

  # Paperclip image attachments
  has_attached_file :banner, :styles => { :thumb => '150x150>', :main => '1200x400#' },
                  :url  => '/assets/banner/:id/:style/:basename.:extension',
                  :path => ':rails_root/public/assets/banner/:id/:style/:basename.:extension'

end
