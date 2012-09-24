$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "rails_admin_images/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "rails_admin_images"
  s.version     = RailsAdminImages::VERSION
  s.authors     = "thamizh"
  s.email       = "thamizh@devbrother.com"
  s.homepage    = "www.devbrother.com"
  s.summary     = "Summary of RailsAdminImages."
  s.description = "Description of RailsAdminImages."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", "~> 3.2.8"
end
