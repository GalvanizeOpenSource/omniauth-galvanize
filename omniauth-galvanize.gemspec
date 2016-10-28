lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'omniauth-galvanize/version'

Gem::Specification.new do |s|
  s.name        = 'omniauth-galvanize'
  s.version     = OmniAuth::Galvanize::VERSION
  s.authors     = ['Chris Cunningham']
  s.email       = ['chris.cunningham@galvanize.com']
  s.homepage    = 'https://github.com/irishkurisu'
  s.summary     = 'Galvanize adapter for OmniAuth.'
  s.license     = 'MIT'

  s.files       = Dir['{lib}/**/*'] + ['MIT.LICENSE', 'README.md']

  s.add_dependency 'omniauth', '~> 1.2'
  s.add_dependency 'multi_json', '~> 1.2'
  s.add_dependency 'omniauth-oauth2', '~> 1.3.1'
end
