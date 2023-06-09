# frozen_string_literal: true

require_relative "lib/fedex/version"

Gem::Specification.new do |spec|
  spec.name = "fedex"
  spec.version = Fedex::VERSION
  spec.authors = ["Alexis Urtecho Ocampo"]
  spec.email = ["alexisurtecho.au@gmail.com"]

  spec.summary = "A Ruby wrapper for the FedEx API."
  spec.description = "This gem provides a simple and intuitive interface to interact with the FedEx API."
  spec.homepage = "https://github.com/Alexis077/fedex"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["allowed_push_host"] = "https://rubygems.org"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/Alexis077/fedex"
  spec.metadata["changelog_uri"] = "https://github.com/Alexis077/fedex/blob/main/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|circleci)|appveyor)})
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "activesupport"
  spec.add_dependency "dry-validation", ">= 1.10", "< 2"
  spec.add_dependency "httparty"
  spec.add_dependency "nokogiri"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
