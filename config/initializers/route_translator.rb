RouteTranslator.config do |config|
  config.force_locale = true
  #puts "I18n.available_locales: #{I18n.available_locales}"
  #config.available_locales = I18n.available_locales
  config.available_locales = [:uk, :ru]
end