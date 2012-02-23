# Concurrent

This Rack middleware records execution times and controller action names for all web requests to Rails applications. This is accomplished by wrapping all calls (similar to Rack::Runtime.) 

## Installation

Simply add it to the Gemfile of your Rails application and metrics will automatically be collected. Extra HTTP headers (`X-Concurrent-Time` and `X-Concurrent-Action`) will be injected when in development mode.

## Usage

Just installing the gem will autoload everything through a Railtie and attach itself to all controller actions through a prepend_before_filter in a Rails engine. Controller name and action names will be detected automatically but can be overridden by setting `Concurrent::Config.configuration.alias` within a method.

```
class ExampleController < ApplicationController
  def super_secret_method
    Concurrent::Config.configuration.alias = 'example#nothing_to_see_here'
  end
end
```

When your application is in development mode, the current controller and action names (or alias if set) will be injected into the HTTP response headers along with the runtime of the action.

```
$ curl -i http://localhost:3000
HTTP/1.1 200 OK 
Content-Type: text/html; charset=utf-8
X-Ua-Compatible: IE=Edge
Etag: "b2d241947a7028a4becb81c27fa08239"
Cache-Control: max-age=0, private, must-revalidate
X-Request-Id: d29d0400310a259a7826bf7024f7b817
X-Runtime: 0.204965
X-Concurrent-Action: example#nothing_to_see_here
X-Concurrent-Time: 0.205004
Server: WEBrick/1.3.1 (Ruby/1.9.3/2011-09-23)
Date: Thu, 23 Feb 2012 07:44:45 GMT
Content-Length: 557
Connection: Keep-Alive
```

You may notice that the time calculated by `Rack::Runtime` is a bit shorter than that reported by `Concurrent::Middleware::Timing`. This is because `Concurrent::Middleware::Timing` is injected before `Rack::Runtime` and as such wraps the entire call within its own timing method.