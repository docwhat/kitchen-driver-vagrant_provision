# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'kitchen/driver/vagrant_provision/version'

Gem::Specification.new do |spec|
  spec.name          = 'kitchen-driver-vagrant_provision'
  spec.version       = Kitchen::Driver::VagrantProvision::VERSION
  spec.authors       = ['Christian Höltje']
  spec.email         = ['docwhat@gerf.org']
  spec.summary       = %q(Kitchen::Driver::VagrantProvision -- A driver for Test Kitchen)
  spec.description   = %q(A driver for Test Kitchen that uses Vagrant provisioning)
  spec.homepage      = 'https://github.com/docwhat/kitchen-driver-vagrant_provision'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'kitchen-vagrant', '~> 0.14'

  spec.add_development_dependency 'bundler', '~> 1.6'
  spec.add_development_dependency 'rake'
end
