module Concurrent
  module Middleware
    class Timing
      def initialize(app)
        @app = app
      end

      def call(env)
        dup._call(env)
      end

      def _call(env)
        start = Time.now
        @status, @headers, @response = @app.call(env)
        duration = Time.now - start

        if Rails.env.development?
          if ::Concurrent::Config.configuration.alias
            @headers['X-Concurrent-Time'] = '%0.6f' % duration
            @headers['X-Concurrent-Action'] = ::Concurrent::Config.configuration.alias
          else
            @headers['X-Concurrent'] = '%0.6f' % duration
            @headers['X-Concurrent-Action'] = '%s#%s' % [::Concurrent::Config.configuration.controller, ::Concurrent::Config.configuration.action]
          end
        end
        
        [@status, @headers, self]
      end

      def each(&block)
        @response.each(&block)
      end
    end
  end
end
