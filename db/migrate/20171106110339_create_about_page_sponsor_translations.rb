class CreateAboutPageSponsorTranslations < ActiveRecord::Migration
  def change
    create_translation_table(AboutPageSponsor, :name, :website_url, :short_description)
  end
end
