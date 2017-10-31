# -*- encoding : utf-8 -*-
class Article < ActiveRecord::Base
  attr_accessible :description, :name, :avatar, :short_description, :featured

  validates :name, presence: true
  validates :slug, uniqueness: true, presence: true
  validates :description, presence: true
  validates :short_description, presence: true

  before_validation :generate_slug_for_article

  has_attached_file :avatar, :styles => { :main => "707x108#", :banner => "1920x360#", :banner_item => "2400x440#", :article_next_pre => "203x98#" }

  def to_param
    slug
  end

  def generate_slug_for_article
    self.slug ||= name.parameterize
  end

	rails_admin do
		label 'Новости'
		label_plural 'Новости'
		list do
			field :featured do
				label 'Отображать баннер'
			end
			field :name do
				label 'Название'
			end
			field :short_description do
				label 'Короткое описание'
			end
		end

		edit do
			field :featured do
				label 'Отображать баннер'
			end
			field :name do
				label 'Название'
			end
			field :short_description do
				label 'Короткое описание'
			end
			field :description do
				ckeditor true
				label 'Описание'
			end
			field :avatar do
				label 'Изображение'
			end
		end
	end
end
