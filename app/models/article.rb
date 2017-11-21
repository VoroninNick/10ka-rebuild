class Article < ActiveRecord::Base
  attr_accessible *attribute_names

  globalize :name, :url_fragment, :short_description, :content

  boolean_scope :published
  boolean_scope :featured
  scope :order_by_release_date, -> { order("release_date desc") }

  default_scope do
    order_by_release_date
  end

  has_seo_tags
  has_sitemap_record

  def self.default_priority
    0.6
  end

  has_cache do
    pages :articles, :home, self, Article.published
  end

  image :avatar, styles: { :main => "707x108#", :banner => "1920x360#", :banner_item => "2400x440#", :article_next_pre => "203x98#" }

  define_resource_methods :get, :url, :year, :formatted_release_date

  def self.base_url(locale = I18n.locale)
    Cms.url_helpers.send("articles_#{locale}_path")
  end

  before_save :init_release_date
  def init_release_date
    self.release_date = self.created_at if self.release_date.blank?
  end




end