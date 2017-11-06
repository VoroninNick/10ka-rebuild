Rails.application.routes.draw do
  root as: "root_without_locale", to: "application#root_without_locale"
  mount Cms::Engine => '/'

  mount Ckeditor::Engine => '/ckeditor'
  get "admin(/*admin_path)", to: redirect{|params| "/#{ I18n.default_locale}/admin/#{params[:admin_path]}"}

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
      get ':id', action: 'sub_category', :as => 'sub_category'
      get ':id', action: 'sub_sub_category', :as => 'sub_sub_category'
      get ':id', action: 'product', :as => 'product'
    end

    get 'unsupported' => 'page#unsupported', :as => 'unsupported'


    match "*url", to: "application#render_not_found", via: :all
  end
end
