# -*- encoding : utf-8 -*-
class Sponsor < ActiveRecord::Base
  attr_accessible :description, :link, :name, :sponsor, :delete_sponsor

  attr_accessor :delete_sponsor
  before_validation { self.sponsor.clear if self.delete_sponsor == '1' }

  # Validate name presence and minimum lenght 2 chars
  validates :name, :presence => true, :length => { :minimum => 2 }
  validates :description, :presence => true, :length => { :minimum => 10 }

  # Paperclip image attachments
  has_attached_file :sponsor, :styles => { :thumb => '150x150>' },
                  :url  => '/assets/sponsor/:id/:style/:basename.:extension',
                  :path => ':rails_root/public/assets/sponsor/:id/:style/:basename.:extension',
                  :hash_secret => '3858f62230ac3c915f300c664312c63f'

end
