# encoding: utf-8

$LOAD_PATH.push File.expand_path('../lib', __FILE__)

require 'capistrano-simple-formatter'

Gem::Specification.new do |spec|
  spec.name          = 'capistrano-simple-formatter'
  spec.version       = CapistranoSimpleFormatter::VERSION
  spec.authors       = ['Rodrigo Díaz V.']
  spec.email         = ['rdiazv89@gmail.com']
  spec.summary       = 'Simple formatter for logging Capistrano tasks'
  spec.description   = 'Simple formatter for logging Capistrano tasks'
  spec.homepage      = 'https://github.com/rdiazv/capistrano-simple-formatter'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'colored', '~> 1.2'
  spec.add_dependency 'sshkit', '~> 1.3'
  spec.add_development_dependency 'bundler', '~> 1.6'
  spec.add_development_dependency 'rake'
end
