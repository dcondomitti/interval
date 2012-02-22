module Concurrent
  class Engine < Rails::Engine
    initializer 'concurrent.inject_middleware', :after => :load_config_initializers do |app|
      ActiveSupport.on_load :after_initialize do
        use Concurrent::Middleware::Timing
      end
    end
  end
end
