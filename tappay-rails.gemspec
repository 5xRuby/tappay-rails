$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "tappay/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "tappay-rails"
  s.version     = TapPay::VERSION
  s.authors     = ["zetavg"]
  s.email       = ["mail@zeta.vg"]
  # s.homepage    = "TODO"
  s.summary     = "API wrapper for www.tappaysdk.com."
  # s.description = "TODO: Description of Tappay::Rails."
  s.license     = "MIT"

  s.files = Dir["{app,config,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", ">= 4.0", "< 5.2"

  s.add_development_dependency "rspec-rails"
end
