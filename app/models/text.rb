class Text < ActiveRecord::Base
  attr_accessible :description, :name

	rails_admin do
		label 'Текста'
		label_plural 'Текста'
		list do
			field :name do
				label 'Название'
			end
			field :description do
				label 'Описание'
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
		end
	end
end
