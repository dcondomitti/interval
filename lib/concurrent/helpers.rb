module Concurrent
  module Helpers

    def self.included(base)
      base.prepend_before_filter :set_concurrent_defaults
    end

    def set_concurrent_defaults
      Concurrent::Config.configure do |config|
        config.controller = params[:controller]
        config.action = params[:action]
      end
    end
  end
end