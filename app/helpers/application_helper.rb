# -*- encoding : utf-8 -*-
module ApplicationHelper
	def proper_name(new_child_catalog_id)
		catalog = NewChildCatalog.find(new_child_catalog_id)
		catalog.name + ' > ' + catalog.new_parent_catalog.name.to_s + ' > ' + catalog.new_parent_catalog.new_catalog.name.to_s
	end

	def main_menu
		entries = ["about_us", "catalog", {controller: "articles"}, "contacts"]
		options = {i18n_title_key: true, i18n_html_title_key: true}
		menu(entries, options)
		#compute_navigation_keys(entries, "menu", true, options)
	end

	def self.copy_data_to_translations(model, locale = :uk)
		attr_names = model.translated_attribute_names
		model.all.each do |model_instance|
			t = model_instance.translations_by_locale[locale] || model_instance.translations.new(locale: locale)
			attr_names.each do |attr_name|
				if t.send(attr_name).blank?
					t.send("#{attr_name}=", model_instance[attr_name.to_s])
				end
			end

			t.save
		end
	end
end
