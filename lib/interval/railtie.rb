require 'rails'

module Interval
  class Railtie < Rails::Railtie
    initializer 'interval.inject_middleware' do |app|

      # Inject Interval middleware before Rack::Runtime to wrap the entire request
      # in timing methods.
      app.config.middleware.insert_before Rack::Runtime, Interval::Middleware::Timing
    end
  end
end