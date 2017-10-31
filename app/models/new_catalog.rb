class NewCatalog < ActiveRecord::Base
  attr_accessible :description, :name, :slug, :new_parent_catalog_ids
	has_many :new_parent_catalogs

  validates :name, presence: true
  validates :slug, uniqueness: true, presence: true

  before_validation :generate_url

  rails_admin do
	  label 'Каталог I уровня'
	  label_plural 'Каталог I уровня'
	  list do
		  field :name do
			  label 'Название'
		  end
		  field :new_parent_catalogs do
			  label 'Саб-категория'
		  end
	  end
	  edit do
		  field :name do
			  label 'Название'
		  end
		  field :description do
			  label 'Описание'
			  ckeditor true
		  end
		  field :slug do
			  read_only true
		  end
		  field :new_parent_catalogs do
			  label 'Саб-категория'
		  end
	  end
  end

  def to_param
	  slug
  end

  def generate_url
	  self.slug ||= name.parameterize
  end
end
