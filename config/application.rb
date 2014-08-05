module ElasticSearch
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Custom directories with classes and modules you want to be autoloadable.
    # config.autoload_paths += %W(#{config.root}/app/concerns #{config.root}/lib)

    # config.time_zone = 'Berlin'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[File.join(%W(#{config.root}/config/locales), '**', '*.{rb,yml}')]

    config.i18n.default_locale = :en
    config.i18n.locale = :en
    config.encoding = "utf-8"

  end
end
