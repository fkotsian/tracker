require File.expand_path('../boot', __FILE__)

require 'rails/all'

Bundler.require(*Rails.groups)

module Trigger
  class Application < Rails::Application
    config.active_record.raise_in_transactional_callbacks = true

    config.generators.template_engine = nil
    config.generators.test_framework = nil
    config.generators.stylesheets = false
    config.generators.javascripts = false
    config.generators.assets = false
    config.generators.helper = false

    config.logger = Logger.new(STDOUT)
  end
end
