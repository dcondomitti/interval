require 'interval/version'
require 'interval/middleware/timing'
require 'interval/config'
require 'interval/railtie' if defined? ::Rails::Railtie
require 'interval/engine' if defined? ::Rails::Engine

module Interval

end