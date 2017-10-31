class NewCatalogController < ApplicationController

	helper_method :get_catalog_by_id, :get_parent_catalog_by_id, :get_child_catalog_by_id, :get_all_parent_catalogs_by_id, :get_all_child_catalogs_by_id, :get_all_products_by_child_ids

  def index
		@new_catalogs = NewCatalog.all
		@description_dummy = Text.find(1)
  end

  def get_catalog
	  @new_catalogs = NewCatalog.all
		@new_catalog = NewCatalog.where(slug: params[:id]).first
  end

  def get_parent
	  @new_catalogs = NewCatalog.all
		@new_parent_catalog = NewParentCatalog.where(slug: params[:id]).first
		@new_catalog = NewCatalog.where(slug: params[:new_catalog_id]).first
		@new_products = NewProduct.where(new_child_catalog_id: NewChildCatalog.where(new_parent_catalog_id: @new_parent_catalog.id))
  end

  def get_child
	  @new_catalogs = NewCatalog.all
	  @new_catalog = NewCatalog.where(slug: params[:new_catalog_id]).first
	  @new_parent_catalog = NewParentCatalog.where(slug: params[:new_parent_catalog_id]).first
		@new_child_catalog = NewChildCatalog.where(slug: params[:id]).first
		@new_products = NewProduct.where(new_child_catalog_id: @new_child_catalog.id)
  end

  def get_product
	  @new_catalogs = NewCatalog.all
	  @new_catalog = NewCatalog.where(slug: params[:new_catalog_id]).first
	  @new_parent_catalog = NewParentCatalog.where(slug: params[:new_parent_catalog_id]).first
	  @new_child_catalog = NewChildCatalog.where(slug: params[:new_child_catalog_id]).first
		@new_product = NewProduct.where(slug: params[:id]).first
  end

	def get_catalog_by_id(id)
		NewCatalog.find(id)
	end

	def get_parent_catalog_by_id(id)
		NewParentCatalog.find(id)
	end

	def get_child_catalog_by_id(id)
		NewChildCatalog.find(id)
	end

	def get_all_parent_catalogs_by_id(id)
		NewParentCatalog.where(new_catalog_id: id)
	end

	def get_all_child_catalogs_by_id(id)
		NewChildCatalog.where(new_parent_catalog_id: id)
	end

	def get_all_products_by_child_ids(ids)
		NewProduct.where(new_child_catalog_id: ids)
	end
end
