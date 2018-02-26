Rails.application.routes.draw do
  if RouteTranslator.config.force_locale
    root as: "root_without_locale", to: "application#root_without_locale"
    get "admin(/*admin_path)", to: redirect{|params| "/#{ I18n.default_locale}/admin/#{params[:admin_path]}"}
  end

  mount Cms::Engine => '/'

  mount Ckeditor::Engine => '/ckeditor'

  localized do
    mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'

    devise_for :users, module: "users", path: "", path_names: {
        sign_in: "login",
        sign_out: 'logout',
    }

    controller "forms" do
      post "contact_request"
    end

    controller :pages do
      root action: :index
      get "about_us"
      get "contacts"

    end

    resources :articles, only: [:index, :show]
    #get 'pasha', to: 'pasha#cmd'
    get 'about' => 'page#about'
    post 'contact' => 'contact#create', :as => 'contact_create'

    # new catalog
    controller "catalog" do
      get 'catalog', action: 'index', :as => 'catalog'
      get ":id", action: 'node', as: :node
      get ':id', action: 'category', :as => 'category'
      get ':id', action: 'subcategory', :as => 'subcategory'
      get ':id', action: 'brand', :as => 'brand'
      get ':id', action: 'product', :as => 'product'
      post ":id/order", action: 'order', as: 'order'
    end

    get 'unsupported' => 'page#unsupported', :as => 'unsupported'


    match "*url", to: "application#render_not_found", via: :all
  end
end
