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
    add_breadcrumb(@category, nil)
  end

  def subcategory(node)
    @subcategory = node
    @category = @subcategory.category
    @products = @subcategory.products
    add_breadcrumb(@category, nil)
    add_breadcrumb(@subcategory, nil)
  end

  def brand(node)
    @brand = node
    @subcategory = @brand.subcategory
    @category = @subcategory.category
    @products = @brand.products

    add_breadcrumb(@category, nil)
    add_breadcrumb(@subcategory, nil)
    add_breadcrumb(@brand, nil)

  end

  def product(node)
    @product = node
    @brand = @product.brand
    @subcategory = @brand.subcategory
    @category = @subcategory.category

    add_breadcrumb(@category, nil)
    add_breadcrumb(@subcategory, nil)
    add_breadcrumb(@brand, nil)
    add_breadcrumb(@product, nil)

  end

  def order
    #@product = Product.joins(:translations).where(product_translations: {url_fragment: params[:id], locale: I18n.locale}).first
    @product = Product.find(params[:product_id]) rescue nil
    return render_not_found if !@product
    request_params = params.permit(:name, :phone, :email, :comment)
    request_params[:product_id] = @product.id
    r = Order.new(request_params)
    r.referer = request.referer
    r.session_id = session.id
    r.save


    render json: {}
  end



  def catalog_node_records_path
    [@category, @subcategory, @brand, @product].select(&:present?)
  end


end