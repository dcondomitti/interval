# Interval

This Rack middleware records execution times and controller action names for all web requests to Rails applications. This is accomplished by wrapping all calls (similar to Rack::Runtime.) Collected data is sent in a StatsD-compatible format over UDP in the background to the reporting service.

## Installation

Simply add it to the Gemfile of your Rails application and metrics will automatically be collected. Extra HTTP headers (`X-Interval-Time` and `X-Interval-Action`) will be injected when in development mode.

## Configuration

No configuration is required to use this gem in development mode. If unconfigured, it will just inject the timing and alias HTTP response headers and serialize statistics data to disk in `Rails.root/log`. The application name is automatically detected by the Rails application name but can be overridden at run-time or in an initializer.

```
Interval::Config.configure do |config|
  config.api_key = 'abcdef012345'
  config.application_name = 'My Awesome App'
end
```

## Usage

Just installing the gem will autoload everything through a Railtie and attach itself to all controller actions through a prepend_before_filter in a Rails engine. Controller name and action names will be detected automatically but can be overridden by setting `Interval::Config.configuration.alias` within a method.

```
class ExampleController < ApplicationController
  def super_secret_method
    Interval::Config.configuration.alias = 'example#nothing_to_see_here'
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
X-Interval-Action: example#nothing_to_see_here
X-Interval-Time: 0.205004
Server: WEBrick/1.3.1 (Ruby/1.9.3/2011-09-23)
Date: Thu, 23 Feb 2012 07:44:45 GMT
Content-Length: 557
Connection: Keep-Alive
```

You may notice that the time calculated by `Rack::Runtime` is a bit shorter than that reported by `Interval::Middleware::Timing`. This is because `Interval::Middleware::Timing` is injected before `Rack::Runtime` and as such wraps the entire call within its own timing method.