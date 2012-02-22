$:.push File.expand_path("../lib", __FILE__)
require "concurrent/version"

Gem::Specification.new do |s|
  s.name = "concurrent"
  s.authors = ["Daniel Condomitti"]
  s.homepage = "https://github.com/dcondomitti/concurrent"
  s.summary = "Adds asyncronous timing and metrics collection to Rails applications."
  s.files = Dir["{app,lib,config}/**/*"] + ["Rakefile", "Gemfile", "README.md"]
  s.version = Concurrent::VERSION
end
