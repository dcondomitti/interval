module Interval
  class Engine < Rails::Engine
    initializer 'interval.inject_controller_helpers', :after => :load_config_initializers do |app|

      # Inject our helpers into all controllers that inherit from ActionController
      # (basically every one.) self#included methods in the helpers module automatically
      # loads the before_filters to set the controller name and action on every request.
      ActiveSupport.on_load(:action_controller) do
        require 'interval/helpers'
        include Interval::Helpers
      end

    end
  end
end
