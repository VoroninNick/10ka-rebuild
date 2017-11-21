# -*- encoding : utf-8 -*-
class ArticlesController < ApplicationController
  caches_page :index, :show

  def index
    articles
    @featured_articles = @articles.featured
    set_page_metadata(:articles)

  end

  def show
    @article = Article.get(params[:id])

    if @article.nil?
      return render_not_found
    end

    @og_image = @article.avatar.url(:banner)
    @prev = @article.prev(articles, except_self: true)
    @next = @article.next(articles, except_self: true)
    set_page_metadata(@article)
  end


  private
  def articles
    @articles ||= Article.published
  end

end
