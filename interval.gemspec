$:.push File.expand_path("../lib", __FILE__)
require "interval/version"

Gem::Specification.new do |s|
  s.name = "interval"
  s.authors = ["Daniel Condomitti"]
  s.homepage = "https://github.com/dcondomitti/interval"
  s.summary = "Adds asyncronous timing and metrics collection to Rails applications."
  s.files = Dir["{app,lib,config}/**/*"] + ["Rakefile", "Gemfile", "README.md"]
  s.version = Interval::VERSION
end
