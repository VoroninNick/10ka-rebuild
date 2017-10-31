# -*- encoding : utf-8 -*-
class ArticlesController < ApplicationController

  #caches_page :index, :show, :gzip => :best_speed

  def index
    @articles = Article.all
		@fetuared = Article.featured

  end

  def show
    @article = Article.where(slug: params[:id]).first

		@article_next = Article.where('id < ?', @article.id).order('id asc').first
    if @article_next.nil?
      @article_next = Article.first
    end
    @article_prev = Article.where('id > ?', @article.id).order('id desc').first
    if @article_prev.nil?
      @article_prev = Article.last
    end
    @lasted = Article.last(2)
  end

end
