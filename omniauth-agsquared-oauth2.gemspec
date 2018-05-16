# frozen_string_literal: true

require File.expand_path(
  File.join("..", "lib", "omniauth", "agsquared_oauth2", "version"),
  __FILE__
)

Gem::Specification.new do |gem|
  gem.name          = "omniauth-agsquared-oauth2"
  gem.version       = OmniAuth::AgsquaredOauth2::VERSION
  gem.license       = "MIT"
  gem.summary       = %(An Agsquared OAuth2 strategy for OmniAuth 1.x)
  gem.description   = %(An Agsquared OAuth2 strategy for OmniAuth 1.x. This gem allows you to login to Agsquared with your Ruby app.)
  gem.authors       = ["John Barton"]
  gem.email         = ["jb@phy5ics.com"]
  gem.homepage      = "https://github.com/farmersweb/omniauth-agsquared-oauth2"

  gem.files         = `git ls-files`.split("\n")
  gem.require_paths = ["lib"]

  gem.required_ruby_version = ">= 2.1"

  gem.add_runtime_dependency "omniauth", ">= 1.1.1"
  gem.add_runtime_dependency "omniauth-oauth2", ">= 1.5"

  gem.add_development_dependency "rake", "~> 12.0"
  gem.add_development_dependency "rspec", "~> 3.6"
  gem.add_development_dependency "rubocop", "~> 0.49"
end
