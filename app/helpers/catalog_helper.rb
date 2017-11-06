module CatalogHelper
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

  def get_all_items_from_all_subcatalogs(parent_catalog)
    items = []
    parent_catalog.new_child_catalogs.each do |cc|
      get_all_products_by_child_ids(cc.id).each do |pr|
        items[items.count] = pr
      end
    end

    return items
  end

  def computed_all_items_from_all_subcatalogs(parent_catalog)
    items = get_all_items_from_all_subcatalogs(parent_catalog)
    a = 0
    items.map do|item|
      a+= 1
      if a % 3 == 0
        item_1 = items[a-3]
        item_2 = items[a-2]
        item_3 = items[a-1]
      elsif a % 3 == 2
        item_1 = items[a-2]
        item_2 = items[a-1]
        item_3 = items[a]

      elsif a % 3 == 1
        item_1 = items[a-1]
        item_2 = items[a]
        item_3 = items[a+1]
      end
      row_count = 1
      max_str_length = 1
      length_1 = item_1.name.length
      length_2 = 0
      length_3 = 0
      if item_2 != nil
        length_2 = item_2.name.length
      end

      if item_3 != nil
        length_3 = item_3.name.length
      end

      arr = []
      arr[0] = length_1
      arr[1] = length_2
      arr[2] = length_3

      max_str_length = arr.max

      if max_str_length >= 27
        row_count = 3
      end

      if max_str_length >= 64
        row_count = 4
      end

      if row_count == 1
        desktop_rows_count_class = 'desktop-one-line'
      elsif row_count == 2
        desktop_rows_count_class = 'desktop-two-lines'
      elsif row_count == 3
        desktop_rows_count_class = 'desktop-three-lines'
      elsif row_count == 4
        desktop_rows_count_class = 'desktop-four-lines'
      end

      entry = {item: item, desktop_rows_count_class: desktop_rows_count_class}
      entry
    end
  end
end
