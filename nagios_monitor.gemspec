# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'nagios_monitor/version'

Gem::Specification.new do |spec|
  spec.name          = "nagios_monitor"
  spec.version       = NagiosMonitor::VERSION
  spec.authors       = ["Torsten Eberhardt"]
  spec.email         = ["torsten.eberhardt@akra.de"]
  spec.summary       = %q{monitor with the help of nagios}
  spec.description   = %q{nagios monitoring for applications}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"

  spec.add_development_dependency "rspec", "~> 2.6"

  spec.add_dependency "nagios"
  spec.add_dependency "nagios_helper"
  spec.add_dependency "send_nsca"
end
