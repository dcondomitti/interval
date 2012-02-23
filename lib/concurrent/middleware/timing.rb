module Concurrent
  module Middleware
    class Timing
      def initialize(app)
        @app = app
      end

      # Duplicate #call for thread-safe purposes. Code from railscasts.org comments.
      def call(env)
        dup._call(env)
      end

      # Wrap #call to track response processing time. Inject headers containing timing
      # and action#controller or alias name when in development mode.
      def _call(env)
        start = Time.now
        @status, @headers, @response = @app.call(env)
        duration = Time.now - start

        if Rails.env.development?
          @headers['X-Concurrent-Time'] = '%0.6f' % duration
          if ::Concurrent::Config.configuration.alias
            @headers['X-Concurrent-Action'] = ::Concurrent::Config.configuration.alias
          else
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
