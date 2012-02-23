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

        inject_headers(duration) if Rails.env.development?
        
        [@status, @headers, self]
      end

      def each(&block)
        @response.each(&block)
      end

      def inject_headers(duration)
        @headers['X-Concurrent-Action'] = action_header
        @headers['X-Concurrent-Time'] = '%0.6f' % duration
      end

      def action_header
        return ::Concurrent::Config.configuration.alias if ::Concurrent::Config.configuration.alias
        '%s#%s' % [::Concurrent::Config.configuration.controller, ::Concurrent::Config.configuration.action] unless ::Concurrent::Config.configuration.alias
      end
    end
  end
end
