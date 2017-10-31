# -*- encoding : utf-8 -*-
class Catalog < ActiveRecord::Base
  attr_accessible :description, :name, :parent_catalog_ids, :home_position_id, :slug

  validates :name, presence: true
  validates :slug, uniqueness: true, presence: true

  before_validation :generate_slug_for_catalog

  has_many :parent_catalogs #, :through => :child_catalogs
  belongs_to :home_position
  belongs_to :parent_catalog

  rails_admin do
    label 'Каталог'
    label_plural 'Каталог'

    list do
      field :name do
        label 'Название'
      end
      field :parent_catalogs do
        label 'Родительская категория'
      end
      field :home_position do
        label 'Положение на главной'
      end
    end

    edit do
      field :name do
        label 'Название'
        help 'Обязательное заполнение'
      end
      field :description do
        ckeditor true
        label 'Краткое описание'
        help 'Обязательное заполнение'
      end
      field :parent_catalogs do
        label 'Родительская категория'
      end
      field :home_position do
        label 'Положение на главной'
      end
    end
  end

  def to_param
    slug
  end

  def generate_slug_for_catalog
    self.slug ||= name.parameterize
  end
end



