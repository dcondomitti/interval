require 'rails'

module Concurrent
  class Railtie < Rails::Railtie
    initializer 'concurrent.inject_middleware' do |app|
      app.config.middleware.insert_before Rack::Runtime, Concurrent::Middleware::Timing
    end
  end
end