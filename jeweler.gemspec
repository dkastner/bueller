$:.push File.expand_path("../lib", __FILE__)
require 'jeweler/version'

Gem::Specification.new do |s|
  s.name = "jeweler"
  s.version = Jeweler::VERSION

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Josh Nichols"]
  s.description = "Simple and opinionated helper for creating Rubygem projects on GitHub"
  s.email = "josh@technicalpickles.com"
  s.rdoc_options = ['--charset=UTF-8']
  s.executables = ["jeweler"]
  s.extra_rdoc_files = [
    "ChangeLog.markdown",
    "LICENSE.txt",
    "README.markdown"
  ]
  s.files = Dir.glob('lib/**/*') + Dir.glob('bin/**/*') + 
              ['lib/jeweler/templates/.gitignore',
               'lib/jeweler/templates/.document',
               'lib/jeweler/templates/rspec/.rspec']
  s.homepage = "http://github.com/technicalpickles/jeweler"
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.10"
  s.summary = "Opinionated tool for creating and managing RubyGem projects"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.3.7")
  if s.respond_to? :specification_version then
    s.specification_version = 3
  end


  s.add_runtime_dependency 'bundler', '~> 1.0.9'
  s.add_runtime_dependency 'git', '>= 1.2.5'
  s.add_runtime_dependency 'rake'
  s.add_development_dependency 'activesupport', '~> 2.3.5'
  s.add_development_dependency 'bluecloth'
  s.add_development_dependency 'cucumber', '~> 1.1.4'
  s.add_development_dependency 'redgreen'
  s.add_development_dependency 'rspec', '~> 2.8.0'
  s.add_development_dependency 'sandbox'
  s.add_development_dependency 'timecop'
  s.add_development_dependency 'yard', '~> 0.6.0'
end

