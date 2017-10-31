# -*- encoding : utf-8 -*-
module ApplicationHelper
	def proper_name(new_child_catalog_id)
		catalog = NewChildCatalog.find(new_child_catalog_id)
		catalog.name + ' > ' + catalog.new_parent_catalog.name.to_s + ' > ' + catalog.new_parent_catalog.new_catalog.name.to_s
	end
end
