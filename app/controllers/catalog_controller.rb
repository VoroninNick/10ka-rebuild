class CatalogController < ApplicationController
  def index
    @categories = NewCatalog.all

    @description_dummy = Text.find(1)
  end

  def node
    node = NewCatalog.find_node_by_url_fragment(params[:id])
    if !node
      return render_not_found
    end

    node_type = NewCatalog.node_type(node)
    if !node_type
      return render_not_found
    end

    send(node_type, node)

    render node_type



  end

  def category(node)
    categories
    @category = node
  end

  def sub_category(node)
    @sub_category = node
    @category = @sub_category.new_catalog
    #@products = NewProduct.where(new_child_catalog_id: NewChildCatalog.where(new_parent_catalog_id: @new_parent_catalog.id))
    @products = NewProduct.joins(new_child_catalog: :new_parent_catalog).where(new_parent_catalogs: {id: @sub_category.id})
  end

  def sub_sub_category(node)
    @sub_sub_category = node
    @sub_category = @sub_sub_category.new_parent_catalog
    @category = @sub_category.new_catalog
    @products = @sub_sub_category.new_products
  end

  def product(node)
    @product = node
    @sub_sub_category = @product.new_child_catalog
    @sub_category = @sub_sub_category.new_parent_catalog
    @category = @sub_category.new_catalog
  end

  def categories
    @categories ||= NewCatalog.all
  end

  helper_method :categories

end