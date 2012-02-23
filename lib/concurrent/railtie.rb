require 'rails'

module Concurrent
  class Railtie < Rails::Railtie
    initializer 'concurrent.inject_middleware' do |app|

      # Inject Concurrent middleware before Rack::Runtime to wrap the entire request
      # in timing methods.
      app.config.middleware.insert_before Rack::Runtime, Concurrent::Middleware::Timing
    end
  end
end