#require_relative 'paperclip'
Cms::CompressionConfig.initialize_compression(html_compress: false)
if !ENV["STD_PRECOMPILE"]
  Cms::AssetsPrecompile.initialize_precompile
end

Cms.config.provided_locales do
  [:uk]
end

Cms.config.use_translations false

#IMAGE_OPTIONS = {styles: { thumb: "200x200#", large: {geometry: "1380x700#", **WATERMARK_ORIGINAL_STYLE}, square: "450x450#", wide: "900x450#", medium_square: "680x680#", medium_tall: "680x1040#", small_wide: "680x360#", small_square: "330x330#", popup: {geometry: "1920x1080>", **WATERMARK_ORIGINAL_STYLE} }}
#GALLERY_IMAGE_OPTIONS = {styles: { thumb: "200x200#", large: "1380x700#", square: "450x450#", wide: "900x450#", medium_square: "680x680#", medium_tall: "680x1040#", small_wide: "680x360#", small_square: "330x330#", popup: {geometry: "1920x1080>", **WATERMARK_ORIGINAL_STYLE} }}