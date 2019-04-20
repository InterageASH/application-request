# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'interage/request/version'

Gem::Specification.new do |spec|
  spec.name          = 'interage-request'
  spec.version       = Interage::Request::VERSION
  spec.authors       = ['Walmir Neto']
  spec.email         = ['owalmirneto@gmail.com']

  spec.summary       = 'https://gitlab.com/interage/patterns/request'
  spec.description   = 'https://gitlab.com/interage/patterns/request'
  spec.homepage      = 'https://gitlab.com/interage/patterns/request'

  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] =
      'https://gitlab.com/interage/patterns/request'

    spec.metadata['homepage_uri'] = spec.homepage
    spec.metadata['source_code_uri'] =
      'https://gitlab.com/interage/patterns/request'
    spec.metadata['changelog_uri'] =
      'https://gitlab.com/interage/patterns/request'
  else
    raise 'RubyGems 2.0 or newer is required to protect against ' \
      'public gem pushes.'
  end

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |file|
      file.match(%r{^(test|spec|features)/})
    end
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 2.0'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
end
