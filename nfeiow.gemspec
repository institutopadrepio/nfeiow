# frozen_string_literal: true

require_relative "lib/nfeiow/version"

Gem::Specification.new do |spec|
  spec.name          = "nfeiow"
  spec.version       = Nfeiow::VERSION
  spec.authors       = ["Instituto Padre Pio"]
  spec.email         = ["padrepauloricardo@padrepauloricardo.org"]

  spec.summary       = "A simple wrapper of the NFE io API"
  spec.description   = "A simple wrapper of the NFE io API"
  spec.homepage      = "https://github.com/institutopadrepio/nfeiow"
  spec.license       = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  # spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/institutopadrepio/nfeiow"
  spec.metadata["changelog_uri"] = "https://github.com/institutopadrepio/nfeiow"

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "excon", ">= 0.73.0"

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "pry", "~> 0.13.1"
  spec.add_development_dependency "rake",    "~> 12.3.3"
  spec.add_development_dependency "rspec",   "~> 3.0"
  spec.add_development_dependency "rubocop", "~> 1.7"
  spec.add_development_dependency "solargraph", "~> 0.40"
  spec.add_development_dependency "vcr",     "~> 5.1"
  spec.add_development_dependency "webmock", "~> 3.8"
end
