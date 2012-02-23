module Concurrent
  module Helpers

    # Inject our before_filter (set_concurrent_defaults) into all controllers
    # that inherit from ActionController::Base or that explictily include 
    # Concurrent::Helpers.
    def self.included(base)
      base.prepend_before_filter :set_concurrent_defaults
    end
    
    # Automatically set the controller name and action on each request, can be
    # overridden by setting Concurrent::Config.configure.alias.
    def set_concurrent_defaults
      Concurrent::Config.configure do |config|
        config.controller = params[:controller]
        config.action = params[:action]
      end
    end
  end
end