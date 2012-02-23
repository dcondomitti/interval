module Concurrent
  class Config

    class << self
      attr_accessor :configuration
    end

    def self.configure
      self.configuration ||= Configuration.new
      yield(configuration)
    end

    class Configuration
      attr_accessor :controller, :action, :alias

      def initialize

      end
    end
  end
end