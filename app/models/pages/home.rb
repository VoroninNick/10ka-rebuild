class Pages::Home < Cms::Page
  def url(locale = I18n.locale)
    "/"
  end
end