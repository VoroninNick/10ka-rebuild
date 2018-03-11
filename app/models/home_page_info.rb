class HomePageInfo < ActiveRecord::Base
  attr_accessible *attribute_names

  has_cache do
    pages :home
  end
end
