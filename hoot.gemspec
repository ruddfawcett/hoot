# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'hoot/version'

Gem::Specification.new do |s|
  s.name          = "hoot"
  s.version       = Hoot::VERSION
  s.authors       = ["Rudd Fawcett"]
  s.email         = ["rudd.fawcett@gmail.com"]

  s.summary       = "Send push notifications to your phone when a Terminal process has completed."
  s.description   = ""
  s.homepage      = "https://github.com/ruddfawcett/hoot"
  s.license       = "MIT"

  s.add_dependency "netrc"
  s.add_dependency "json"

  s.files         = Dir["./**/*"].reject { |file| file =~ /\.\/(bin|log|pkg|script|spec|test|vendor)/ }
  s.executables   = ["hoot"]
  s.require_paths = ["lib"]

  s.add_development_dependency "bundler", "~> 1.10"
  s.add_development_dependency "rake", "~> 10.0"
end
