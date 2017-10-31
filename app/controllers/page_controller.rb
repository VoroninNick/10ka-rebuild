# -*- encoding : utf-8 -*-
class PageController < ApplicationController
  #caches_page :index, :about, :gzip => :best_speed

  def index
		@last_article = Article.last(4)
		@banners = Banner.all
		@text = Text.find(2)
  end

  def about
		@text_about = Text.find(3)

		@about_page = AboutPage.first
  end

	def unsupported
		@text_unsupported = Text.find(4)
		render :layout => 'unsupported'
	end
end
