class PagesController < ApplicationController
	before_action :set_page_instance, except: [:index]
  caches_page :index, :about_us, :contacts

  def index
		@last_article = Article.last(4)
		@banners = Banner.all
		#@text = Text.find(2)
		@home_page_info = HomePageInfo.first_or_initialize
		@home_categories = Category.all
		set_page_metadata(:home)
  end

  def about_us
		#@text_about = Text.find(3)
		@about_sponsors = AboutPageSponsor.published
		@about_page_info = AboutPageInfo.first_or_initialize
	end

	def contacts
		@contact_request = ContactRequest.new
	end

	def unsupported
		@text_unsupported = Text.find(4)
		render :layout => 'unsupported'
	end

	def set_page_instance
		set_page_metadata(action_name)
		#@_locale_links ||= {}
		#Cms.config.provided_locales.each do |locale|
		#	@_locale_links[locale.to_sym] = send("#{action_name}_#{I18n.locale}_path")
		#end
	end
end
