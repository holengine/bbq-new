require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module BbqNewV
  class Application < Rails::Application
    config.load_defaults 7.0
    config.i18n.default_locale = :ru
    config.generators.system_tests = nil
  end
end
