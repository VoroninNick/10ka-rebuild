#require_relative 'paperclip'
Cms::CompressionConfig.initialize_compression(html_compress: false)
if !ENV["STD_PRECOMPILE"]
  Cms::AssetsPrecompile.initialize_precompile
end

Cms.config.provided_locales do
  [:uk, :ru]
end

Cms.config.use_translations true
