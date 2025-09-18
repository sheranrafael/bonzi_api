require_relative "boot"

require "rails"
# Import only what we need
require "action_controller/railtie"
require "action_view/railtie"
require "rails/test_unit/railtie"

Bundler.require(*Rails.groups)

module TransacoesApi
  class Application < Rails::Application
    config.load_defaults 7.0
    config.api_only = true
    
    # CORS configuration
    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins '*'
        resource '*',
          headers: :any,
          methods: [:get, :post, :delete, :options]
      end
    end
  end
end