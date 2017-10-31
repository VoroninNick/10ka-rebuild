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

	rails_admin do
		label 'Баннера главной страницы'
		label_plural 'Баннера главной страницы'
		list do
			field :name do
				label 'Название'
			end
			field :description do
				label 'Описание'
			end
			field :banner do
				label 'Изображение'
			end
		end
		edit do
			field :name do
				label 'Название'
			end
			field :description do
				label 'Описание'
			end
			field :banner do
				label 'Изображение'
			end
			field :url do
				label 'Ссылка'
			end
		end
	end

end
