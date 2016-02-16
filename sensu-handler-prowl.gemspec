lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'date'

Gem::Specification.new do |s|
  s.authors                = ['Andre Tiengo']
  s.date                   = Date.today.to_s
  s.description            = 'Sensu handler for prowl notifications'
  s.email                  = '<andretiengo@gmail.com>'
  s.executables            = Dir.glob('bin/**/*').map { |file| File.basename(file) }
  s.files                  = Dir.glob('{bin,lib}/**/*') + %w(LICENSE README.md CHANGELOG.md)
  s.homepage               = 'https://github.com/tiengo/sensu-handler-prowl'
  s.license                = 'MIT'
  s.name                   = 'sensu-handler-prowl'
  s.platform               = Gem::Platform::RUBY
  s.post_install_message   = 'You can use the embedded Ruby by setting EMBEDDED_RUBY=true in /etc/default/sensu'
  s.require_paths          = ['lib']
  s.required_ruby_version  = '>= 1.9.3'
  s.summary                = 'Sensu handler for prowl notifications'
  s.test_files             = s.files.grep(%r{^(test|spec|features)/})
  s.version                = '0.0.1'

  s.add_runtime_dependency 'sensu-plugin', '1.2.0'
  s.add_runtime_dependency 'prowl',      '0.1.4'

  s.add_development_dependency 'bundler',                   '~> 1.7'
  s.add_development_dependency 'codeclimate-test-reporter', '~> 0.4'
  s.add_development_dependency 'github-markup',             '~> 1.3'
  s.add_development_dependency 'pry',                       '~> 0.10'
  s.add_development_dependency 'rake',                      '~> 10.5'
  s.add_development_dependency 'redcarpet',                 '~> 3.2'
  s.add_development_dependency 'rspec',                     '~> 3.4'
  s.add_development_dependency 'rubocop',                   '~> 0.37'
  s.add_development_dependency 'yard',                      '~> 0.8'
end
