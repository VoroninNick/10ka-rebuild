# -*- encoding : utf-8 -*-
class CatalogsController < ApplicationController
  respond_to :html, :xml

  def index
    @catalogs ||= Catalog.all
    respond_with(@catalogs)
		@description_dummy = Text.find(1)
  end

  def show
    @catalog ||= Catalog.find_by_slug!(params[:id])
    respond_with(@catalog)
  end

  # GET /catalog/parent/1
  # GET /catalog/parent/1.json <- Given all Child categories by a parent id
  # GET /catalog/parent/1.xml
  def show_parent
    @parent_catalog = ParentCatalog.find_by_slug!(params[:id])
    @get_child_xml = ChildCatalog.find_all_by_parent_catalog_id(@parent_catalog.id)
    @catalog_slug = Catalog.find(@parent_catalog.catalog_id)
    #@get_child_json_last ||= @get_child_json.last
    respond_with(@parent_catalog)
  end

  # GET /catalog/parent/child/1
  # GET /catalog/parent/child/1.json
  # GET /catalog/parent/child/1.xml
  def show_child
    @child_catalog ||= ChildCatalog.find_by_slug!(params[:id])
    @parent_catalog ||= ParentCatalog.find(@child_catalog.parent_catalog_id)
    @catalog_slug ||= Catalog.find(@parent_catalog.catalog_id)
    respond_with(@child_catalog)
  end

  # GET /catalog/parent/child/product/1
  # GET /catalog/parent/child/product/1.json
  # GET /catalog/parent/child/product/1.xml
  def show_product
    @product ||= Product.find_by_slug!(params[:id])
    respond_with(@product)
  end

end
