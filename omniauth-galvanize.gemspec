lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'omniauth-galvanize/version'

Gem::Specification.new do |gem|
  gem.add_dependency 'omniauth', '~> 1.2'
  gem.add_dependency 'multi_json', '~> 1.2'
  gem.add_dependency 'omniauth-oauth2', '~> 1.3'

  gem.authors       = ['Chris Cunningham']
  gem.email         = ['chris.cunningham@galvanize.com']
  gem.description   = %q{Galvanize adapter for OmniAuth.}
  gem.summary       = gem.description
  gem.homepage      = 'https://github.com/irishkurisu'
  gem.license       = 'MIT'

  gem.executables   = `git ls-files -- bin/*`.split("\n").collect { |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = 'omniauth-galvanize'
  gem.require_paths = ['lib']
  gem.version       = OmniAuth::Galvanize::VERSION
end