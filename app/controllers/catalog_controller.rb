class CatalogController < ApplicationController
  caches_page :index, :node

  def index
    all_categories

    @description_dummy = Text.find(1)
  end

  def node
    @node = Category.find_node_by_url_fragment(params[:id])
    if !@node
      return render_not_found
    end

    @node_type = Category.node_type(@node)
    if !@node_type
      return render_not_found
    end

    send(@node_type, @node)

    template_name = @node_type
    if template_name == "category" || template_name == "subcategory" || template_name == "brand"
      template_name = "base_category"
    end
    render template_name



  end

  def category(node)
    all_categories
    @category = node
    @products = @category.products
    add_breadcrumb(@category, nil, categories(@category))
  end

  def subcategory(node)
    @subcategory = node
    @category = @subcategory.category
    @products = @subcategory.products
    add_breadcrumb(@category, nil, categories)
    add_breadcrumb(@subcategory, nil, subcategories_by_category(@category, @subcategory))
  end

  def brand(node)
    @brand = node
    @subcategory = @brand.subcategory
    @category = @subcategory.category
    @products = @brand.products

    add_breadcrumb(@category, nil, categories)
    add_breadcrumb(@subcategory, nil, subcategories_by_category(@category))
    add_breadcrumb(@brand, nil, brands_by_subcategory(@subcategory))

  end

  def product(node)
    @product = node
    @brand = @product.brand
    @subcategory = @brand.subcategory
    @category = @subcategory.category

    add_breadcrumb(@category, nil, categories)
    add_breadcrumb(@subcategory, nil, subcategories_by_category(@category))
    add_breadcrumb(@brand, nil, brands_by_subcategory(@subcategory))
    add_breadcrumb(@product, nil, @brand.products.where.not(products: {id: @product.id }))

  end



  def catalog_node_records_path
    [@category, @subcategory, @brand, @product].select(&:present?)
  end


end