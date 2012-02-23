require 'concurrent/version'
require 'concurrent/middleware/timing'
require 'concurrent/config'
require 'concurrent/railtie' if defined? ::Rails::Railtie
require 'concurrent/engine' if defined? ::Rails::Engine

module Concurrent

end