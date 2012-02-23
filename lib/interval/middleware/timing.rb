module Interval
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

        inject_headers(duration) if (defined? Rails && Rails.env.development?) || env['RACK_ENV'] == 'development'
        
        [@status, @headers, self]
      end

      def each(&block)
        @response.each(&block)
      end

      def inject_headers(duration)
        @headers['X-Interval-Action'] = action_header
        @headers['X-Interval-Time'] = '%0.6f' % duration
      end

      def action_header
        return ::Interval::Config.configuration.alias if ::Interval::Config.configuration.alias
        '%s#%s' % [::Interval::Config.configuration.controller, ::Interval::Config.configuration.action]
      end
    end
  end
end
