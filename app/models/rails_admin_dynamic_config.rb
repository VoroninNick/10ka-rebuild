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
              only [Cms::Page, BlogArticleCategory, TeamMember, Vacancy, Client]
            end

            ## With an audit adapter, you can add:
            # history_index
            # history_show
          end


          config.parent_controller = "ApplicationController"
        end

        config.navigation_labels do
          {
            feedbacks: 100,
            lattice_flooring: 110,
            stairs: 120,
            installation: 130,
            manual: 140,
            home: 200,
            about_us: 300,
            blog: 400,
            news: 500,
            contacts: 600,
            terms_of_use: 850,
            tags: 1000,
            users: 1100,
            settings: 1200,
            pages: 1300,
            assets: 1400
          }
        end

        config.navigation_static_links = {
           mailchimp: "/admin/mailchimp",
           locales: "/file_editor/locales",
           site_data: "/file_editor/site_data.yml"
        }


        #
        #
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

        config.include_models Attachable::Asset

        config.model Attachable::Asset do
          navigation_label_key(:assets, 1)
          field :data
          #watermark_position_field(:data)
          field :sorting_position
          field :translations, :globalize_tabs
        end

        config.model_translation Attachable::Asset do
          field :locale, :hidden
          field :data_alt
        end


        config.include_models User
        config.model User do
          navigation_label_key(:users, 1)
          field :email
          field :password
          field :password_confirmation
        end

        config.include_models Cms::Tag, Cms::Tagging

        config.model Cms::Tag do
          navigation_label_key(:tags, 1)
          field :translations, :globalize_tabs
          field :videos
        end

        config.model_translation Cms::Tag do
          field :locale, :hidden
          field :name
          field :url_fragment do
            help do
              I18n.t("admin.help.#{name}")
            end
          end
        end

        config.model Cms::Tagging do
          visible false
        end

        # ===================================================
        # Requests
        # ===================================================
        config.configure_forms(ContactRequest)

        # ===================================================
        # Application specific models
        # ===================================================
        config.include_models NewsArticle, BlogArticle, BlogArticleCategory, LatticeFlooringCategory, LatticeFlooringPageInfo
        config.include_models InstallationPageInfo, StairsPageInfo, InstallationFeature, StairsFeature
        config.include_models ManualArticle, ManualPageInfo
        config.include_models Album, AlbumTag, ExamplesPageInfo
        config.include_models HomeSlide
        config.include_models AboutUsPageInfo
        config.include_models TermsOfUsePageInfo
        config.include_models NewsPageInfo, BlogPageInfo
        config.include_models TeamMember, Vacancy, Client, Certificate

        config.model NewsArticle do
          navigation_label_key(:news, 1)

          field :published
          field :translations, :globalize_tabs
          field :banner
          field :release_date do
            date_format do
              :short
            end
          end
          field :seo_tags
        end

        config.model_translation NewsArticle do
          field :locale, :hidden
          field :name
          field :url_fragment
          field :short_description
          field :content, :ck_editor
        end

        config.model BlogArticle do
          navigation_label_key(:blog, 1)

          field :published
          field :blog_article_category
          field :translations, :globalize_tabs
          field :banner
          field :release_date do
            date_format do
              :short
            end
          end
          field :seo_tags
        end

        config.model_translation BlogArticle do
          field :locale, :hidden
          field :name
          field :url_fragment
          field :content, :ck_editor
        end

        config.model BlogArticleCategory do
          navigation_label_key(:blog, 2)
          nestable_list({position_field: :sorting_position})

          field :translations, :globalize_tabs
        end

        config.model_translation BlogArticleCategory do
          field :locale, :hidden
          field :name
          field :url_fragment
        end

        config.model LatticeFlooringCategory do
          navigation_label_key(:lattice_flooring, 2)
          nestable_list({position_field: :sorting_position})

          field :published
          field :translations, :globalize_tabs
          field :attachment
          field :banner
          field :albums

        end

        config.model_translation LatticeFlooringCategory do
          field :locale, :hidden
          field :name
          field :url_fragment
          field :content, :ck_editor
          field :attachment_name

        end

        config.model LatticeFlooringPageInfo do
          navigation_label_key(:lattice_flooring, 3)
          field :banner_image
          field :home_image
          field :translations, :globalize_tabs
        end

        config.model_translation LatticeFlooringPageInfo do
          field :locale, :hidden
          field :banner_title
          field :banner_subtitle
          field :intro, :ck_editor
          field :short_description
        end

        config.model InstallationPageInfo do
          navigation_label_key(:installation, 1)
          field :banner_image
          field :home_image
          field :translations, :globalize_tabs
          field :gallery_images
        end

        config.model_translation InstallationPageInfo do
          field :locale, :hidden
          field :banner_title
          field :banner_subtitle
          field :intro, :ck_editor
          field :features_title
        end

        config.model StairsPageInfo do
          navigation_label_key(:stairs, 1)
          field :banner_image
          field :home_image
          field :translations, :globalize_tabs

        end

        config.model_translation StairsPageInfo do
          field :locale, :hidden
          field :banner_title
          field :banner_subtitle
          field :intro, :ck_editor
          field :short_description
        end

        config.model InstallationFeature do
          navigation_label_key(:installation, 2)
          nestable_list({position_field: :sorting_position})

          field :published
          field :image
          field :translations, :globalize_tabs
        end

        config.model_translation InstallationFeature do
          field :locale, :hidden
          field :name
          field :description
        end

        config.model StairsFeature do
          navigation_label_key(:stairs, 2)
          nestable_list({position_field: :sorting_position})

          field :published
          field :image
          field :translations, :globalize_tabs
        end

        config.model_translation StairsFeature do
          field :locale, :hidden
          field :name
          field :description
        end

        config.model ManualArticle do
          navigation_label_key(:manual, 1)
          nestable_list({position_field: :sorting_position})

          field :published
          field :banner_image
          field :translations, :globalize_tabs
        end

        config.model_translation ManualArticle do
          field :locale, :hidden
          field :name
          field :url_fragment
          field :content, :ck_editor
        end

        config.model ManualPageInfo do
          navigation_label_key(:manual, 2)
          field :banner_image
          field :translations, :globalize_tabs
          field :downloads
        end

        config.model_translation ManualPageInfo do
          field :locale, :hidden
          field :banner_title
          field :banner_subtitle
        end

        config.model Album do
          navigation_label_key(:examples, 1)

          linkable_field([LatticeFlooringCategory], :catalog_category)
          field :album_tag
          field :published
          field :translations, :globalize_tabs
          field :images
        end

        config.model_translation Album do
          field :locale, :hidden
          field :name
          field :url_fragment
        end

        config.model AlbumTag do
          navigation_label_key(:examples, 2)

          field :translations, :globalize_tabs
        end

        config.model_translation AlbumTag do
          field :locale, :hidden
          field :name
          field :url_fragment
        end

        config.model ExamplesPageInfo do
          navigation_label_key(:examples, 3)
          field :banner_image
          field :translations, :globalize_tabs
        end

        config.model_translation ExamplesPageInfo do
          field :locale, :hidden
          field :banner_title
          field :banner_subtitle
        end

        config.model HomeSlide do
          navigation_label_key :home, 1
          nestable_list({position_field: :sorting_position})

          field :published
          linkable_field([Cms::Page, LatticeFlooringCategory])
          field :translations, :globalize_tabs
          field :image
          field :show_link_in_title
          field :button_text
        end

        config.model_translation HomeSlide do
          field :locale, :hidden
          field :description_html, :ck_editor
        end

        config.model AboutUsPageInfo do
          navigation_label_key :about_us, 1

          field :banner_image
          field :translations, :globalize_tabs
        end

        config.model_translation AboutUsPageInfo do
          field :locale, :hidden
          field :banner_title
          field :banner_subtitle
          field :who_we_are_html, :ck_editor
          field :mission_html, :ck_editor
          field :team_intro, :ck_editor
          field :vacancies_intro, :ck_editor
          field :clients_intro, :ck_editor
          field :certificates_intro, :ck_editor
        end

        config.model TermsOfUsePageInfo do
          field :banner_image
          field :translations, :globalize_tabs
        end

        config.model_translation TermsOfUsePageInfo do
          field :locale, :hidden
          field :banner_title
          field :banner_subtitle
          field :content, :ck_editor
        end

        config.model NewsPageInfo do
          navigation_label_key :news, 2

          field :banner_image
          field :translations, :globalize_tabs
        end

        config.model_translation NewsPageInfo do
          field :banner_title
          field :banner_subtitle
        end

        config.model BlogPageInfo do
          navigation_label_key :blog, 3
          field :banner_image
          field :translations, :globalize_tabs
        end

        config.model_translation BlogPageInfo do
          field :banner_title
          field :banner_subtitle
        end

        config.model Certificate do
          navigation_label_key :about_us, 2

          field :published
          field :date do
            date_format do
              :short
            end
          end
          field :translations, :globalize_tabs
          field :avatar
          field :document
        end

        config.model_translation Certificate do
          field :locale, :hidden
          field :name
          field :description
        end

        config.model TeamMember do
          navigation_label_key :about_us, 2
          nestable_list({position_field: :sorting_position})

          field :published
          field :translations, :globalize_tabs
          field :image
        end

        config.model_translation TeamMember do
          field :locale, :hidden
          field :name
          field :position
        end

        config.model Vacancy do
          navigation_label_key :about_us, 2
          nestable_list({position_field: :sorting_position})

          field :published
          field :translations, :globalize_tabs
        end

        config.model_translation Vacancy do
          field :locale, :hidden
          field :name
          field :url_fragment
          field :salary_description
          field :content, :ck_editor
        end

        config.model Client do
          navigation_label_key :about_us, 2
          nestable_list({position_field: :sorting_position})

          field :published
          field :translations, :globalize_tabs
          field :image
        end

        config.model_translation Client do
          field :locale, :hidden
          field :name
          field :website_url
        end

      end
    end
  end
end