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
