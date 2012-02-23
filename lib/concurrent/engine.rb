module Concurrent
  class Engine < Rails::Engine
    initializer 'concurrent.inject_before_filter', :after => :load_config_initializers do |app|
      ActiveSupport.on_load(:action_controller) do
        require 'concurrent/helpers'
        include Concurrent::Helpers
      end
    end
  end
end
