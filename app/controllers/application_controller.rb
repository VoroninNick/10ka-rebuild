# -*- encoding : utf-8 -*-
class ApplicationController < ActionController::Base
  #protect_from_forgery

  include ActionView::Helpers::OutputSafetyHelper
  include Cms::Helpers::ImageHelper
  include ActionView::Helpers::AssetUrlHelper
  include ActionView::Helpers::TagHelper
  include ActionView::Helpers::UrlHelper
  include Cms::Helpers::UrlHelper
  include Cms::Helpers::PagesHelper
  include Cms::Helpers::MetaDataHelper
  include Cms::Helpers::NavigationHelper
  include Cms::Helpers::ActionView::UrlHelper
  include Cms::Helpers::Breadcrumbs
  include ActionControllerExtensions::InstanceMethods
  include ApplicationHelper
  include Cms::Helpers::AnotherFormsHelper
  include Cms::Helpers::TagsHelper

  helper_method :fetch_sponsors, :fetch_banners, :fetch_all_catalog, :get_left_catalogs, :get_center_catalogs, :get_right_catalogs, :fetch_all_child, :fetch_all_products, :count_childs, :child_name_breadcrumb, :parent_name_breadcrumb, :catalog_name_breadcrumb, :get_first_child, :parent_slug, :fetch_all_child_ids, :fetch_all_products_by_parent

  def root_without_locale
    redirect_to root_path(locale: I18n.locale)
  end

  def render_not_found
    @render_footer = false
    render template: "errors/not_found.html.slim", status: 404, layout: "application"
  end

  def fetch_sponsors
    @fetch_sponsors ||= Sponsor.last(6)
  end

  def fetch_banners
    @fetch_banners ||= Banner.all
  end

  def get_left_catalogs
    @catalog_first ||= HomePosition.find(1)
  end

  def get_center_catalogs
    @catalog_middle ||= HomePosition.find(2)
  end

  def get_right_catalogs
    @catalog_last ||= HomePosition.find(3)
  end

  def fetch_all_catalog
    @catalogs ||= Catalog.all
  end

  def fetch_all_child(ids)
    @childs ||= ChildCatalog.where(parent_catalog_id: ids)
  end

  def fetch_all_child_ids(ids)
    @childs ||= ChildCatalog.where(parent_catalog_id: ids).id
  end

  def get_first_child(ids)
    @child ||= ChildCatalog.where(parent_catalog_id: ids).first
  end

  def parent_slug(parent_id)
    @parent_slug = ParentCatalog.find(parent_id).url_fragment
  end

  def fetch_all_products(ids)
    @products ||= Product.where(child_catalog_id: ids)
  end

  def fetch_all_products_by_parent(ids)
    @products ||= Product.where(parent_catalog_id: ids)
  end

  def count_childs(ids)
    @count ||= ChildCatalog.where(parent_catalog_id: ids).count
  end

  def child_name_breadcrumb(id)
    @child_name_breadcrumb ||= ChildCatalog.find(id)
  end

  def parent_name_breadcrumb(id)
    @parent_name_breadcrumb ||= ParentCatalog.find(id)
  end

  def catalog_name_breadcrumb(id)
    @catalog_name_breadcrumb ||= Catalog.find(id)
  end

  def phone_url(phone)
    "tel:" + phone.gsub(/[\s\(\)]/, "")
  end  

  def main_site_phone
    "+38 (032) 244 00 22"
  end

  def office_phone
    "+38 (032) 244 00 00"
  end

  def sales_phone
    "+38 (032) 244 00 15"
  end

  def office_phone_url
    phone_url(office_phone)
  end  

  def main_site_phone_url
    phone_url(main_site_phone)
  end

  def sales_phone_url
    phone_url(sales_phone)
  end

  def fax_phone
    "+38 (032) 244 00 09"
  end

  def collection_except(relation, except = nil)
    if except
      if except.respond_to?(:id)
        except_id = except.id
      elsif except.is_a?(Fixnum)
        except_id = except
      end

      if except_id
        relation = relation.where.not("#{relation.klass.table_name}": {id: except_id})
      end
    end

    relation
  end

  def all_categories
    @categories ||= categories
  end

  def categories(except = nil)
    rel = Category.all
    rel = collection_except(rel, except)
    rel.joins(:products).uniq
  end

  def brands_by_subcategory(subcategory, except = nil)
    rel = Brand.where(subcategory_id: subcategory.id)
    rel = collection_except(rel, except)
    rel.joins(:products).uniq
  end

  def subcategories_by_category(category, except = nil)
    rel = Subcategory.where(category_id: category.id)
    rel = collection_except(rel, except)
    rel.joins(:products).uniq
  end

  helper_method :all_categories, :brands_by_subcategory, :subcategories_by_category

  helper_method :main_site_phone, :phone_url, :main_site_phone_url, :office_phone, :office_phone_url, :fax_phone, :sales_phone, :sales_phone_url
end
