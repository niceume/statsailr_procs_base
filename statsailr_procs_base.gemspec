# frozen_string_literal: true

require_relative "lib/statsailr_procs_base/version"

Gem::Specification.new do |spec|
  spec.name          = "statsailr_procs_base"
  spec.version       = StatSailr::ProcsBase::VERSION
  spec.authors       = ["Toshihiro Umehara"]
  spec.email         = ["toshi@niceume.com"]

  spec.summary       = "Collection of fundamental PROCs for StatSailr program"
  spec.description   = "This 'statsailr_procs_base' gem provides a collection of fundamental PROCs for StatSailr program. This gem is essential for StatSailr to provide a useful statistics system."
  spec.homepage      = "https://github.com/niceume/statsailr_procs_base"
  spec.license       = "GPL-3.0"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

#  spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = spec.homepage

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"

  # For more information and examples about making a new gem, checkout our
  # guide at: https://bundler.io/guides/creating_gem.html
end
