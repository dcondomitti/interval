module Concurrent
  class Config

    class << self
      attr_accessor :configuration
    end

    # http://robots.thoughtbot.com/post/344833329/mygem-configure-block
    def self.configure
      self.configuration ||= Configuration.new
      yield(configuration)
    end

    # TODO: Figure out a better way to set the method alias instead of 
    # Concurrent::Config.configuration.alias. Maybe a helper method on the main module? ugh.

    class Configuration
      attr_accessor :controller, :action, :alias

      def initialize

      end
    end
  end
end