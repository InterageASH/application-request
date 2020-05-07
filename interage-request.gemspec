# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'interage/request/version'

Gem::Specification.new do |spec|
  spec.name          = 'interage-request'
  spec.version       = Interage::Request::VERSION
  spec.authors       = ['Walmir Neto']
  spec.email         = ['owalmirneto@gmail.com']

  spec.summary       = 'Application Request for Interage'
  spec.description   = 'Use Net::HTTP to make requests'
  spec.homepage      = 'https://gitlab.com/interage/patterns/request'
  spec.licenses      = ['MIT']

  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = 'https://rubygems.org'

    spec.metadata['homepage_uri'] = spec.homepage
    spec.metadata['source_code_uri'] = spec.homepage
    spec.metadata['changelog_uri'] = "#{spec.homepage}/blob/master/CHANGES"
  else
    raise 'RubyGems 2.0 or newer is required to protect against ' \
      'public gem pushes.'
  end

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |file|
      file.match(%r{^(test|spec|features)/}) || file.split('.').last == 'gem'
    end
  end

  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 2.0'
  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
end
