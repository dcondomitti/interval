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
        @headers['X-Concurrent'] = '%0.6f' % duration
        [@status, @headers, self]
      end

      def each(&block)
        @response.each(&block)
      end
    end
  end
end
