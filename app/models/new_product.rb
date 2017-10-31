class NewProduct < ActiveRecord::Base
  attr_accessible :description, :name, :new_child_catalog_id, :new_child_catalog, :slug, :avatar, :delete_avatar
	has_one :new_child_catalog
  #accepts_nested_attributes_for :new_child_catalog
  belongs_to :new_child_catalog
  #belongs_to :new_parent_catalog
  #has_and_belongs_to_many :new_child_catalogs


  validates :name, presence: true
  validates :slug, uniqueness: true, presence: true

  before_validation :generate_url

  # remove avatar image
  attr_accessor :delete_avatar
  before_validation { self.avatar.clear if self.delete_avatar == '1' }

  has_attached_file :avatar, :styles => { :thumb => '180>', :prod => '190x190#', :main => '420x420#' },
                    :url  => '/assets/pr/:id/:style/:basename.:extension',
                    :path => ':rails_root/public/assets/pr/:id/:style/:basename.:extension'

  rails_admin do
	  label 'Товар'
	  label_plural 'Товары'

	  edit do
		  field :name do
			  label 'Название'
		  end
		  field :description do
			  label 'Описание'
			  ckeditor true
		  end
		  field :new_child_catalog do
			  label 'Категория'
			  inline_add false
			  #enum do
				#  ['1a', '1b', '2a', '2b', '3a', '3b', '4a', '4b', '5']
			  #end
			  #enum do
				#  except = bindings[:object].id.nil? ? 0 : bindings[:object].id
				#  NewChildCatalog.where("id != ?", except).map { |c| [ c.name, c.id, c.new_parent_catalog ] }
			  #end
			  #formatted_value do
				#  new_child_catalog_id = bindings[:object].new_child_catalog_id
				#  proper_name = bindings[:view].proper_name(new_child_catalog_id)
				#  bindings[:view].link_to "#{proper_name}", '#' #bindings[:view].rails_admin.edit_path('new_child_catalog', new_child_catalog_id)
			  #end
		  end

		  field :avatar do
				label 'Изображение'
		  end
		  field :slug do
			  read_only true
			  label 'Ссылка'
		  end
	  end
	  list do
		  field :name do
			  label 'Название'
		  end
		  field :new_child_catalog do
			  label 'Категория'
			  pretty_value do
				  new_child_catalog_id = bindings[:object].new_child_catalog_id
				  proper_name = bindings[:view].proper_name(new_child_catalog_id)
				  bindings[:view].link_to "#{proper_name}", bindings[:view].rails_admin.show_path('new_child_catalog', new_child_catalog_id)
			  end
		  end
		  field :slug do
			  label 'Ссылка'
		  end
		  field :avatar do
			  label 'Изображение'
		  end
	  end
  end



  def to_param
	  slug
  end

  def generate_url
	  url = name
	  self.slug ||= url.parameterize
  end

end
