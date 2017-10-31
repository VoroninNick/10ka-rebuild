class NewChildCatalog < ActiveRecord::Base
  attr_accessible :description, :name, :new_parent_catalog_id, :slug
	has_many :new_products
	belongs_to :new_parent_catalog

  validates :name, presence: true
  validates :slug, uniqueness: true, presence: true

  before_validation :generate_url

  rails_admin do
	  label 'Каталог III уровня'
	  label_plural 'Каталог III уровня'
	  list do
		  field :name do
			  label 'Название'
		  end
		  field :new_parent_catalog do
			  label 'Каталог (II уровень)'
		  end
	  end
	  edit do
		  field :name do
			  label 'Название'
		  end
		  field :new_parent_catalog do
				label 'Каталог (II уровень)'
		  end
		  field :description do
			  ckeditor true
			  label 'Описание'
		  end
		  field :slug do
			  read_only true
			  label 'url'
		  end

	  end
  end

  def to_param
	  slug
  end

  def generate_url
		url = name + '-' + new_parent_catalog.name
	  self.slug ||= url.parameterize
  end

  def self.fullname
		"#{self.new_parent_catalog.name} #{self.name}"
  end

  #def self.name
	 # parent_catalog = NewCatalog.find(self.new_parent_catalog).first
	 # self.new_catalog.name = "#{parent_catalog.name self.name}"
  #end

end
