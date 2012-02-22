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
        @start = Time.now
        @status, @headers, @response = @app.call(env)
        @stop = Time.now
        [@status, @headers, self]
      end

      def each(&block)
        duration = @stop - @start
        block.call("<!-- #{duration} -->")
        @response.each(&block)
      end
    end
  end
end
