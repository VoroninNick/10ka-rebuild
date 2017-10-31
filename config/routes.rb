Rails.application.routes.draw do
  #get '/dev/cmd', to:'developer_panel#command_line'
  #get '/dev', to: 'developer_panel#index'
  #post "/dev/file_upload", to: "developer_panel#file_upload", as: :file_upload
  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'
  mount Ckeditor::Engine => '/ckeditor'
  devise_for :users
  resources :articles, only: [:index, :show]
  #get 'pasha', to: 'pasha#cmd'
  get 'about' => 'page#about'
  get 'contact' => 'contact#new', :as => 'contact'
  post 'contact' => 'contact#create', :as => 'contact_create'
  get 'catalog' => 'catalogs#index', :as => 'catalog_main'
  get 'catalog/:id' => 'catalogs#show', :as => 'catalog_show'
  get 'catalog/:catalog_id/:id' => 'catalogs#show_parent', :as => 'parent_show'
  get 'catalog/:catalog_id/:parent_catalog_id/:id' => 'catalogs#show_child', :as => 'child_show'
  get 'catalog/:catalog_id/:parent_catalog_id/:child_catalog_id/:id' => 'catalogs#show_product', :as => 'product_show'
  get 'public/xml/gmap' => redirect('/public/xml/gmap.xml')

  # new catalog
  get 'c' => 'new_catalog#index', :as => 'new_catalog_all'
  get 'c/:id' => 'new_catalog#get_catalog', :as => 'new_catalog'
  get 'c/:new_catalog_id/:id' => 'new_catalog#get_parent', :as => 'new_catalog_parent'
  get 'c/:new_catalog_id/:new_parent_catalog_id/:id' => 'new_catalog#get_child', :as => 'new_catalog_child'
  get 'c/:new_catalog_id/:new_parent_catalog_id/:new_child_catalog_id/:id' => 'new_catalog#get_product', :as => 'new_product'
  get 'unsupported' => 'page#unsupported', :as => 'unsupported'
  root to: 'page#index'
end
