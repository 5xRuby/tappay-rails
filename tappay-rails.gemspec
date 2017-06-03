$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "tappay/rails/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "tappay-rails"
  s.version     = Tappay::Rails::VERSION
  s.authors     = ["zetavg"]
  s.email       = ["mail@zeta.vg"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of Tappay::Rails."
  s.description = "TODO: Description of Tappay::Rails."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 5.1.1"
end
