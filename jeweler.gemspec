$:.push File.expand_path("../lib", __FILE__)
require 'jeweler/version'

Gem::Specification.new do |s|
  s.name = %q{jeweler}
  s.version = Jeweler::VERSION
  s.date = %q{2010-08-21}
  s.authors = ["Josh Nichols"]
  s.email = %q{josh@technicalpickles.com}
  s.homepage = 'http://github.com/dkastner/jeweler'
  s.summary = 'Tools for building gems with bundler and friends'
  s.description = %q{Simple and opinionated helper for creating Rubygem projects on GitHub}
  s.rdoc_options = ['--charset=UTF-8']
  s.extra_rdoc_files = [
    "LICENSE",
    "README.markdown"
  ]

  s.required_rubygems_version = Gem::Requirement.new(">= 1.3.7")
  s.rubygems_version = '1.3.7'
  s.specification_version = 3

  s.require_paths = ['lib']
  s.executables = ['jeweler']
  s.default_executable = 'jeweler'
  s.files = Dir.glob('lib/**/*') + Dir.glob('bin/**/*') + 
              ['lib/jeweler/templates/.gitignore',
               'lib/jeweler/templates/.document',
               'lib/jeweler/templates/rspec/.rspec']
  s.test_files = Dir.glob('spec/**/*')

  s.add_runtime_dependency 'bundler', '~> 1.0.9'
  s.add_runtime_dependency 'git', '>= 1.2.5'
  s.add_runtime_dependency 'rake'
  s.add_development_dependency 'activesupport', '~> 2.3.5'
  s.add_development_dependency 'bluecloth'
  s.add_development_dependency 'cucumber'
  s.add_development_dependency 'redgreen'
  s.add_development_dependency 'rspec', '~> 2.8.0'
  s.add_development_dependency 'sandbox'
  s.add_development_dependency 'timecop'
  s.add_development_dependency 'yard', '~> 0.6.0'
end

