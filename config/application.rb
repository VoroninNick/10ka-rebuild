require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module App10k
  class Application < Rails::Application
    config.active_record.raise_in_transactional_callbacks = true

    config.time_zone = 'Kyiv'
    config.active_record.default_timezone = :local

    config.i18n.available_locales = [:uk]
    config.i18n.default_locale = :uk

    Rails.application.config.action_mailer.default_url_options = {host: (ENV["#{Rails.env}.host_with_port"] || ENV["#{Rails.env}.host"])}

    config.i18n.load_path += Dir[Rails.root.join("config/locales/**/*.yml").to_s]



    # ckeditor
    Rails.application.config.assets.precompile += %w(ckeditor/* ckeditor/lang/*)
    config.assets.enabled = true
    config.assets.precompile += Ckeditor.assets
    config.autoload_paths += %W(#{config.root}/app/models/ckeditor)

    # file_editor
    config.assets.precompile += %w(fonts/octicons/octicons.woff cms/file_editor.css cms/file_editor.js)
  end
end
