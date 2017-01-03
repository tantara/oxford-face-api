# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'oxford/face/api/version'

Gem::Specification.new do |spec|
  spec.name          = "oxford-face-api"
  spec.version       = Oxford::Face::Api::VERSION
  spec.authors       = ["Taekmin Kim"]
  spec.email         = ["tantara.tm@gmail.com"]

  spec.summary       = %q{Oxford Face API}
  spec.description       = %q{Microsoft Oxford Face API}
  spec.homepage      = "https://github.com/tantara/oxford-face-api"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "http://TODO.com"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.10.1"

  spec.add_dependency "rake", ">= 10.0"
  spec.add_dependency "json", ">= 2.0"
end
