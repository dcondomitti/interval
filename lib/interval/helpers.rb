module Interval
  module Helpers

    # Inject our before_filter (set_interval_defaults) into all controllers
    # that inherit from ActionController::Base or that explictily include 
    # Interval::Helpers.
    def self.included(base)
      base.prepend_before_filter :set_interval_defaults
    end
    
    # Automatically set the controller name and action on each request, can be
    # overridden by setting Interval::Config.configure.alias.
    def set_interval_defaults
      Interval::Config.configure do |config|
        config.alias = nil
        config.controller = params[:controller]
        config.action = params[:action]
      end
    end
  end
end