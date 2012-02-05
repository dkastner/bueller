# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "existing-project/version"

Gem::Specification.new do |s|
  s.name = %q{existing-project}
  s.version = ExistingProject::VERSION

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Josh Nichols"]
  s.email = %q{josh@technicalpickles.com}
  s.extra_rdoc_files = ["README.rdoc", "LICENSE.txt"]
  s.files = Dir.glob('lib/**/*.rb')
  s.test_files = Dir.glob('test/**/*.rb')
  s.has_rdoc = true
  s.homepage = %q{http://github.com/technicalpickles/existing-project-with-version}
  s.rdoc_options = ["--inline-source", "--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{Summarize your gem}
end
