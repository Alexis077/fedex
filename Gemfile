# frozen_string_literal: true

source "https://rubygems.org"

# Specify your gem's dependencies in fedex.gemspec
gemspec

gem "rake", "~> 13.0"

gem "rspec", "~> 3.0"

gem "rubocop", "~> 1.21"

group :test do
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
  gem "webmock"
  gem "vcr"
end
