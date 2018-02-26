module RailsAdminDynamicConfig
  class << self
    def configure_rails_admin(initial = true)
      RailsAdmin.config do |config|

        ### Popular gems integration

        ## == Devise ==
        config.authenticate_with do
          warden.authenticate! scope: :user
        end
        config.current_user_method(&:current_user)

        ## == Cancan ==
        #config.authorize_with :cancan

        ## == Pundit ==
        # config.authorize_with :pundit

        ## == PaperTrail ==
        # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

        ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration



        if initial
          config.actions do
            dashboard                     # mandatory
            index                         # mandatory
            new do
              #except [CallRequest, ConsultationRequest, MeterRequest, ContactsRequest, PartnershipRequest]
            end
            export
            bulk_delete
            show
            edit
            delete
            show_in_app
            props do
              only []
            end
            #edit_model
            nestable do
              only [AboutPageSponsor]
            end

            ## With an audit adapter, you can add:
            # history_index
            # history_show
          end


          config.parent_controller = "ApplicationController"
        end

        config.navigation_labels do
          [:feedbacks, :lattice_flooring, :stairs, :installation, :manual, :home, :about_us, :blog, :news, :contacts, :terms_of_use, :tags, :users, :settings, :pages, :assets]
        end

        config.navigation_static_links = {

        }




        config.include_models Cms::SitemapElement, Cms::MetaTags
        config.include_models Cms::Page
        config.model Cms::Page do
          navigation_label_key(:pages, 1)
          nestable_list({position_field: :sorting_position, scope: :order_by_sorting_position})
          object_label_method do
            :custom_name
            #{
            #k = @bindings[:object].type.underscore.split("/").last
            #I18n.t("activerecord.models.pages.#{k}", raise: true) rescue k.humanize
            #}
          end
          list do
            sort_by do
              "sorting_position"
            end

            field :name do
              def value
                k = @bindings[:object].type.underscore.split("/").last
                I18n.t("activerecord.models.pages.#{k}", raise: true) rescue k.humanize
              end
            end

            field :h1_text do
              def value
                @bindings[:object].h1_text
              end
            end
          end

          edit do
            field :name do
              read_only true
              def value
                k = @bindings[:object].type.underscore.split("/").last
                I18n.t("activerecord.models.pages.#{k}", raise: true) rescue k.humanize
              end
            end
            field :translations, :globalize_tabs
            field :seo_tags

          end

        end

        config.model_translation Cms::Page do
          field :locale, :hidden
          field :h1_text
        end


        config.model Cms::MetaTags do
          visible false
          field :translations, :globalize_tabs
        end

        config.model_translation Cms::MetaTags do
          field :locale, :hidden
          field :title
          field :keywords
          field :description
        end


        config.model Cms::SitemapElement do
          visible false

          field :display_on_sitemap
          field :changefreq
          field :priority
        end
        #
        # config.include_models Attachable::Asset
        #
        # config.model Attachable::Asset do
        #   navigation_label_key(:assets, 1)
        #   field :data
        #   #watermark_position_field(:data)
        #   field :sorting_position
        #   field :translations, :globalize_tabs
        # end
        #
        # config.model_translation Attachable::Asset do
        #   field :locale, :hidden
        #   field :data_alt
        # end


        config.include_models User
        config.model User do
          navigation_label_key(:users, 1)
          field :email
          field :password
          field :password_confirmation
        end

        # config.include_models Cms::Tag, Cms::Tagging
        #
        # config.model Cms::Tag do
        #   navigation_label_key(:tags, 1)
        #   field :translations, :globalize_tabs
        #   field :videos
        # end
        #
        # config.model_translation Cms::Tag do
        #   field :locale, :hidden
        #   field :name
        #   field :url_fragment do
        #     help do
        #       I18n.t("admin.help.#{name}")
        #     end
        #   end
        # end
        #
        # config.model Cms::Tagging do
        #   visible false
        # end

        # ===================================================
        # Requests
        # ===================================================
        #config.configure_forms(ContactRequest)

        # ===================================================
        # Application specific models
        # ===================================================

        #config.include_models AboutPage, AboutPageSponsor, Banner, Catalog, ChildCatalog, ContactMessageReceiver, HomePosition
        #config.include_models NewCatalog, NewChildCatalog, NewParentCatalog, NewProduct, ParentCatalog, Product
        #config.include_models Sponsor, Text

        config.configure_forms(Order)

        config.model Order do
          navigation_label_key(:feedbacks, 1)

          field :product
          field :name
          field :email
          field :phone
          field :comment
          field :referer
          field :session_id
        end

        config.model Article do
          navigation_label_key(:blog, 1)

          field :published
          field :featured
          field :translations, :globalize_tabs
          field :avatar
          field :release_date do
            date_format do
              :short
            end
          end
          field :seo_tags
        end

        config.model_translation Article do
          field :locale, :hidden
          field :name
          field :url_fragment
          field :short_description
          field :content, :ck_editor
        end

        config.model Banner do
          navigation_label_key(:home, 1)
          list do
            field :name
            field :description
            field :banner
          end
          edit do
            field :name
            field :description
            field :banner
            field :url
          end
        end

        config.model HomePageInfo do
          navigation_label_key(:home, 2)
          field "about_text", :ck_editor
        end

        config.model HomePosition do
          visible false
        end

        config.model Category do
          label 'Каталог I уровня'
          label_plural 'Каталог I уровня'
          list do
            translated_field :name
          end
          edit do
            field :name
            field :description, :ck_editor
            field :url_fragment
          end
        end

        config.model_translation Category do

        end

        config.model Brand do
          label 'Каталог III уровня'
          label_plural 'Каталог III уровня'
          list do
            translated_field :name
            field :subcategory do
              label 'Каталог (II уровень)'
            end
          end
          edit do
            field :subcategory
            field :translations, :globalize_tabs

          end
        end

        config.model_translation Brand do
          field :name
          field :url_fragment
          field :description, :ck_editor
        end

        config.model Subcategory do
          label 'Каталог II уровня'
          label_plural 'Каталог II уровня'
          list do
            field :name
          end
          edit do
            field :category
            field :translations, :globalize_tabs
          end
        end

        config.model_translation Subcategory do
          field :name
          field :url_fragment
          field :description, :ck_editor
        end

        config.model Product do
          list do
            translated_field :name
            field :brand
            translated_field :url_fragment
            field :avatar
          end
          edit do
            field :brand
            field :translations, :globalize_tabs
            field :avatar
          end
        end

        config.model_translation Product do
          field :name
          field :url_fragment
          field :description, :ck_editor
        end




        config.model Text do
          label 'Текста'
          label_plural 'Текста'
          list do
            field :name do
              label 'Название'
            end
            field :description do
              label 'Описание'
            end
          end
          edit do
            field :name do
              label 'Название'
            end
            field :description, :ck_editor do
              label 'Описание'
            end
          end
        end


        config.model AboutPageInfo do
          navigation_label_key(:about_us, 1)

          field :translations, :globalize_tabs
        end

        config.model_translation AboutPageInfo do
          field :locale, :hidden
          field :page_title
          field :intro, :ck_editor
          field :sponsors_short_description
          field :sales_description, :ck_editor
        end

        config.model AboutPageSponsor do
          navigation_label_key(:about_us, 1)
          nestable_list({position_field: :sorting_position, scope: :order_by_sorting_position})

          list do
            field :published
            translated_field :name
            field :website_url
            field :avatar

          end

          edit do
            field :published
            field :avatar
            field :translations, :globalize_tabs
          end
        end

        config.model_translation AboutPageSponsor do
          field :locale, :hidden
          field :name
          field :website_url
          field :short_description
        end
      end
    end
  end
end