class Ckeditor::Asset < ActiveRecord::Base
  include Ckeditor::Orm::ActiveRecord::AssetBase
  include Ckeditor::Backend::Paperclip
	rails_admin do
		label 'Файл'
		label_plural 'Файлы'
	end
end
