# encoding: utf-8

require 'bundler'
Bundler.setup

require 'jeweler'
Jeweler::Tasks.new

require 'yard'
YARD::Rake::YardocTask.new do |t|
  t.files   = FileList['lib/**/*.rb'].exclude('lib/jeweler/templates/**/*.rb')
end

require 'rspec/core/rake_task'
desc "Run all rspec examples"
RSpec::Core::RakeTask.new('spec') do |c|
  c.rspec_opts = '-Ispec'
end

require 'cucumber/rake/task'
Cucumber::Rake::Task.new(:features) do |features|
  features.cucumber_opts = "features --format progress"
end
namespace :features do
  Cucumber::Rake::Task.new(:pretty_features) do |features|
    features.cucumber_opts = "features --format progress"
  end
end

task :default => [:features, :spec]
